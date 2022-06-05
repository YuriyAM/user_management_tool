import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/models/OperationalLogAction.dart';
import 'package:user_management_tool/models/RegisterLogAction.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/providers/OperationalLogProvider.dart';
import 'package:user_management_tool/providers/RegisterLogProvider.dart';
import 'package:user_management_tool/widgets/textfields/ConfirmPasswordField.dart';
import 'package:user_management_tool/widgets/textfields/NewPasswordField.dart';

final passwordRegex = RegExp(r'^[a-zA-Z0-9!(),\-.\/:;?\\|]{8,}$');

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({Key? key}) : super(key: key);

  @override
  _CreatePasswordPageState createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final _newPassword = TextEditingController();

  bool _validPassword = false;
  bool _validConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    OperationalLogProvider.insert(Logger(action: OperationalLogAction.OPEN_PASSWORD_PAGE));
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Create new password",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: NewPasswordField(
              controller: _newPassword,
              setValidity: (validity) => _validPassword = validity,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: ConfirmPasswordField(
              getPassword: () => _newPassword.text,
              setValidity: (validity) => _validConfirmPassword = validity,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onLongPress: null,
            onPressed: () {
              _validPassword && _validConfirmPassword
                  ? _createPassword(_newPassword.text)
                  : null;
            },
            child: const Text("Create password"),
          ),
        ],
      ),
    );
  }

  _createPassword(String newPassword) async {
    RegisterLogProvider.insert(Logger(action: RegisterLogAction.CHANGE_PASSWORD));
    CURRENT_USER?.password = newPassword;
    DatabaseProvider.updateUser(CURRENT_USER!);
    Navigator.pushNamed(context, '/home');
  }
}
