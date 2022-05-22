import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/providers/RegisterProvider.dart';

class RegisterSoftwareDialog extends StatefulWidget {
  const RegisterSoftwareDialog({Key? key}) : super(key: key);

  @override
  State<RegisterSoftwareDialog> createState() => _RegisterSoftwareDialogState();
}

class _RegisterSoftwareDialogState extends State<RegisterSoftwareDialog> {
  final registerKey = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var validator;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade100,
      title: const Text("Register software"),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Form(
            key: _formKey,
            child: TextFormField(
              // style: TextStyle(color: Colors.white),
              controller: registerKey,
              autofocus: true,
              validator: (value) => validator,
              decoration: const InputDecoration(
                hintText: "Enter registration code",
                labelStyle: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: const Text('Register'),
          onPressed: () => _registerSoftware(),
        ),
      ],
    );
  }

  _validateRegistration() async {
    if (registerKey.text == null) {
      return "Please, enter registration code";
    }

    var validity = await RegisterProvider.registerSoftware(
      CURRENT_USER!,
      registerKey.text,
    );

    if (validity == false) {
      return "Entered key is wrong";
    } else {
      return null;
    }
  }

  _registerSoftware() async {
    validator = await _validateRegistration();
    setState(() {});

    if (!_formKey.currentState!.validate()) {
      return null;
    }
    Navigator.of(context).pop();
  }
}
