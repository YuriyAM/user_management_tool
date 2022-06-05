import 'package:flutter/material.dart';
import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/models/RegisterLogAction.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/providers/RegisterLogProvider.dart';

class EditUserDialog extends StatefulWidget {
  final User user;

  const EditUserDialog({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final username = TextEditingController();
  late final userData;

  @override
  void initState() {
    userData = User(
      username: widget.user.username,
      password: widget.user.password,
      enabled: widget.user.enabled,
      privileged: widget.user.privileged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade100,
      title: const Text("Edit user"),
      content: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
              enabled: false,
              obscureText: false,
              controller: TextEditingController(text: userData.username),
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
              enabled: false,
              obscureText: true,
              controller: TextEditingController(text: userData.password),
              decoration: InputDecoration(
                labelText:
                    userData.password == "" ? "Password not set" : "Password",
              ),
            ),
          ),
          Row(
            children: [
              const Text("Privileged user"),
              Checkbox(
                value: userData.privileged,
                onChanged: (bool? value) => setState(
                  () => userData.privileged = value!,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("Enable user"),
              Checkbox(
                value: userData.enabled,
                onChanged: (bool? value) => setState(
                  () => userData.enabled = value!,
                ),
              )
            ],
          )
        ]),
      ),
      actions: <Widget>[
        MaterialButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        MaterialButton(
          child: const Text('Save'),
          onPressed: () => _saveUser(userData),
        ),
      ],
    );
  }

  _saveUser(User userData) async {
    widget.user.update(userData);
    RegisterLogProvider.insert(Logger(action: RegisterLogAction.CHANGE_PRIVILEGES));
    await DatabaseProvider.updateUser(userData);
    Navigator.of(context).pop();
  }
}
