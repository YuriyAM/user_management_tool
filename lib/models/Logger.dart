import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/LogLevel.dart';
import 'package:user_management_tool/models/OperationalLogAction.dart';

import 'User.dart';

class Logger {
  String timestamp = DateTime.now().toIso8601String();
  LogLevel level;
  User? user = CURRENT_USER;
  Enum action;

  Logger({required this.action, this.level = LogLevel.INFO});

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'level': level.toString().split('.').last,
      'user': user!.username,
      'action': action.toString().split('.').last,
    };
  }
}
