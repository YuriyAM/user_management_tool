import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/widgets/cards/UserCard.dart';
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
              setValidity: (validity) => _validOldPassword = validity,
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
              _validOldPassword && _validPassword && _validConfirmPassword
                  ? _updatePassword(_newPassword.text)
                  : null;
            },
            child: const Text("Update password"),
          ),
        ],
      ),
    );
  }

  _updatePassword(String newPassword) async {
    CURRENT_USER?.password = newPassword;
    DatabaseProvider.updateUser(CURRENT_USER!);
    Navigator.pushNamed(context, '/home');
  }
}
