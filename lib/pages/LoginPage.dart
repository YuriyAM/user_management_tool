import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Credentials.dart';
import 'package:user_management_tool/models/Registration.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/providers/RegisterProvider.dart';
import 'package:user_management_tool/widgets/dialogs/LoginAlertDialog.dart';
import 'package:user_management_tool/widgets/dialogs/RegisterSoftwareDialog.dart';
import 'package:user_management_tool/widgets/textfields/UsernameField.dart';
import 'package:user_management_tool/widgets/textfields/PasswordField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Image(width: 200, image: AssetImage('lib/images/logo.png')),
          const SizedBox(height: 20),
          SizedBox(width: 300, child: UsernameField(controller: username)),
          const SizedBox(height: 20),
          SizedBox(width: 300, child: PasswordField(controller: password)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => loginUser(),
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }

  checkRegistration() async {
    User u = User(username: username.text);
    await RegisterProvider.login(u);
  }

  loginUser() async {
    Credentials creds =
        Credentials(username: username.text, password: password.text);
    if (creds.username == "") {
      return;
    }

    var u = await DatabaseProvider.checkCredentials(creds);

    // If user cannot login
    if (u == false) {
      await LoginAlertDialog(content: "User or password is incorrect")
          .show(context);
      return;
    } else if (u.enabled == false) {
      await LoginAlertDialog(
        content:
            "User is disabled. Please, contact your administrator for more details.",
      ).show(context);
      return;
    }

    // If user is able to login, but should register
    CURRENT_USER = u;

    if (await RegisterProvider.login(u) == false) {
      await LoginAlertDialog(
        content: "Please, register software",
      ).show(context);
      await showDialog<dynamic>(
        barrierDismissible: false,
        context: context,
        builder: (_) => const RegisterSoftwareDialog(),
      );
      setState(() {});
    }

    var reg = await RegisterProvider.find(Registration.fromUser(u));
    if (reg.registered == false && reg.remained > 0) {
      await LoginAlertDialog(
        content:
            """This is the trial version of software. After ${reg.remained} more login(s) you will have to register this product.""",
      ).show(context);
    } else if (reg.registered == false && reg.remained == 0) {
      await LoginAlertDialog(
        content:
            """This is the trial version of software. On the next login you will have to register this product.""",
      ).show(context);
    }

    if (u.password == '') {
      await LoginAlertDialog(content: "Please, create password").show(context);
      Navigator.pushNamed(context, '/change_password');
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }
}
