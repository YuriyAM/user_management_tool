import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Credentials.dart';
import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/models/OperationalLogAction.dart';
import 'package:user_management_tool/models/RegisterLogAction.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/providers/OperationalLogProvider.dart';
import 'package:user_management_tool/providers/RegisterLogProvider.dart';
import 'package:user_management_tool/widgets/cards/UserCard.dart';
import 'package:user_management_tool/widgets/dialogs/LoginAlertDialog.dart';
import 'package:user_management_tool/widgets/textfields/ConfirmPasswordField.dart';
import 'package:user_management_tool/widgets/textfields/NewPasswordField.dart';
import 'package:user_management_tool/widgets/textfields/OldPasswordField.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();

  bool _validOldPassword = false;
  bool _validPassword = false;
  bool _validConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    OperationalLogProvider.insert(
        Logger(action: OperationalLogAction.OPEN_ACCOUNT_PAGE));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          const SizedBox(
              width: 300,
              child: ListTile(
                onTap: null,
                minLeadingWidth: 0,
                leading: Icon(Icons.manage_accounts),
                title: Text(
                  "Account management",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: UserCard(
              user: CURRENT_USER!,
              notifyParent: () => setState(() {}),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
              width: 300,
              child: ListTile(
                onTap: null,
                minLeadingWidth: 0,
                leading: Icon(Icons.vpn_key),
                title: Text(
                  "Change password",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: OldPasswordField(
              controller: _oldPassword,
            ),
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
                  ? _updatePassword(_newPassword.text)
                  : null;
            },
            child: const Text("Update password"),
          ),
        ],
      ),
    );
  }

  _validateOldPassword() async {
    Credentials creds = Credentials(
        username: CURRENT_USER!.username, password: _oldPassword.text);
    var u = await DatabaseProvider.checkCredentials(creds);
    if (u == false) {
      await LoginAlertDialog(content: "Please, enter correct current password")
          .show(context);
      return false;
    } else {
      return true;
    }
  }

  _updatePassword(String newPassword) async {
    if (!await _validateOldPassword()) {
      return null;
    }
    RegisterLogProvider.insert(Logger(action: RegisterLogAction.CHANGE_PASSWORD));
    CURRENT_USER?.password = newPassword;
    DatabaseProvider.updatePassword(CURRENT_USER!);
    Navigator.pushNamed(context, '/home');
  }
}
