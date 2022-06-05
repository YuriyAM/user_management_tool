import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';

class IdentificationFailedDialog {
  static show(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.popUntil(
        context,
        ModalRoute.withName("/login"),
      ),
    );

    AlertDialog identityAlert = AlertDialog(
      content: const Text("Your session has timed out. Please login again"),
      actions: [okButton],
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return identityAlert;
      },
    );
  }
}
