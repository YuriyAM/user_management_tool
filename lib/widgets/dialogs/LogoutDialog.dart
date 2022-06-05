import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/models/OperationalLogAction.dart';
import 'package:user_management_tool/models/RegisterLogAction.dart';
import 'package:user_management_tool/providers/OperationalLogProvider.dart';
import 'package:user_management_tool/providers/RegisterLogProvider.dart';

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
            RegisterLogProvider.insert(Logger(action: RegisterLogAction.LOG_OFF));
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
