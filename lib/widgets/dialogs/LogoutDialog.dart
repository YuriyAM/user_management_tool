import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';

class LogoutDialog {
  show(BuildContext context) {
    AlertDialog loginAlert = AlertDialog(
      content: const Text("Do you want to logout?"),
      actions: <Widget>[
        MaterialButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        MaterialButton(
          child: const Text('Yes'),
          onPressed: () {
            CURRENT_USER = null;
            Navigator.popUntil(
              context,
              ModalRoute.withName("/login"),
            );
          },
        ),
      ],
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return loginAlert;
      },
    );
  }
}
