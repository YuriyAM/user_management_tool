import 'package:flutter/material.dart';

class LoginAlertDialog {
  final String content;
  LoginAlertDialog({required this.content});

  show(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    AlertDialog loginAlert = AlertDialog(
      content: Text(content),
      actions: [okButton],
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return loginAlert;
      },
    );
  }
}
