import 'package:flutter/material.dart';
import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/models/RegisterLogAction.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/providers/RegisterLogProvider.dart';

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({Key? key}) : super(key: key);

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  final username = TextEditingController();
  bool privileged = false;
  bool enabled = true;

  final _formKey = GlobalKey<FormState>();
  var validator;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade100,
      title: const Text("New user"),
      content: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Form(
              key: _formKey,
              child: TextFormField(
                // style: TextStyle(color: Colors.white),
                controller: username,
                autofocus: true,
                validator: (value) => validator,
                decoration: const InputDecoration(
                  hintText: "Username",
                  labelStyle: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Text("Privileged user"),
              Checkbox(
                value: privileged,
                onChanged: (bool? value) => setState(() => privileged = value!),
              )
            ],
          ),
          Row(
            children: [
              const Text("Enable user"),
              Checkbox(
                value: enabled,
                onChanged: (bool? value) => setState(() => enabled = value!),
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
          child: const Text('Add'),
          onPressed: () => _addUser(),
        ),
      ],
    );
  }

  _validateUser() async {
    if (username.text == null || username.text.length < 3) {
      return "Username is too short";
    } else if (!RegExp(r'^[a-zA-Z0-9_]{3,}$').hasMatch(username.text)) {
      return "Username contains invalid character";
    }

    final u = User(username: username.text);
    if (await DatabaseProvider.findUser(u) != false) {
      return "Username should be unique";
    } else {
      return null;
    }
  }

  _addUser() async {
    validator = await _validateUser();
    setState(() {});

    if (!_formKey.currentState!.validate()) {
      return null;
    }

    final u = User(
      username: username.text,
      enabled: enabled,
      privileged: privileged,
    );
    await DatabaseProvider.insertUser(u);
    username.clear();
    Navigator.of(context).pop(u);
  }
}
