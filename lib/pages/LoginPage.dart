import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Credentials.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/widgets/dialogs/LoginAlertDialog.dart';
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

  loginUser() async {
    Credentials creds =
        Credentials(username: username.text, password: password.text);
    if (creds.username == "") {
      return;
    }

    var u = await DatabaseProvider.checkCredentials(creds);

    if (u == false) {
      await LoginAlertDialog(content: "User or password is incorrect")
          .show(context);
    } else if (u.enabled == false) {
      await LoginAlertDialog(
        content:
            "User is disabled. Please, contact your administrator for more details.",
      ).show(context);
    } else if (u.password == '') {
      CURRENT_USER = u;
      await LoginAlertDialog(content: "Please, create password").show(context);
      Navigator.pushNamed(context, '/change_password');
    } else {
      CURRENT_USER = u;
      Navigator.pushNamed(context, '/home');
    }
  }
}
