import 'package:flutter/material.dart';
import 'package:user_management_tool/models/User.dart';

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
              controller: TextEditingController(text: widget.user.username),
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
              controller: TextEditingController(text: widget.user.password),
              decoration: InputDecoration(
                labelText: widget.user.password == ""
                    ? "Password not set"
                    : "Password",
              ),
            ),
          ),
          Row(
            children: [
              const Text("Privileged user"),
              Checkbox(
                value: widget.user.privileged,
                onChanged: (bool? value) => setState(
                  () => widget.user.privileged = value!,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("Enable user"),
              Checkbox(
                value: widget.user.enabled,
                onChanged: (bool? value) => setState(
                  () => widget.user.enabled = value!,
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
          onPressed: () => {},
        ),
      ],
    );
  }
}

RegExp ipRegExp =
    RegExp(r"^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\.(?!$)|$)){4}$");
