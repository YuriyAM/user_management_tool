import 'package:flutter/material.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/widgets/dialogs/LoginAlertDialog.dart';

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
  final TextEditingController username = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade100,
      title: Text("Edit user"),
      content: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
              enabled: false,
              obscureText: false,
              controller: TextEditingController(text: widget.user.username),
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
              Text("Privileged user"),
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
              Text("Enable user"),
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
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        MaterialButton(
          child: Text('Save'),
          onPressed: () => {},
        ),
      ],
    );
  }

  _validateUser() async {
    if (username.text == null || username.text.length < 3) {
      return "Username is too small";
    }
    print("hellllloo");
    final u = User(username: username.text);
    if (await DatabaseProvider.findUser(u) != false) {
      return "Username should be unique";
    } else {
      return null;
    }
  }

  // _addUser() async {
  //   validator = await _validateUser();
  //   setState(() {});

  //   if (!_formKey.currentState!.validate()) {
  //     return null;
  //   }

  //   final u = User(
  //     username: username.text,
  //     enabled: enabled,
  //     privileged: privileged,
  //   );
  //   await DatabaseProvider.insertUser(u);
  //   username.clear();
  //   Navigator.of(context).pop(u);
  // }
}

RegExp ipRegExp =
    RegExp(r"^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\.(?!$)|$)){4}$");
