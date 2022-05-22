import 'package:user_management_tool/models/Credentials.dart';

import 'User.dart';

class Registration {
  String username;
  String key;
  int remained;
  bool? registered;

  Registration({
    required this.username,
    this.key = "superencryptedkey",
    this.remained = 10,
    this.registered = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'key': key,
      'remained': remained,
      'registered': registered,
    };
  }

  Registration.fromUser(User user)
      : username = user.username,
        key = user.username,
        remained = 10,
        registered = user.privileged! ? true : false;

  Registration.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        key = map['key'],
        remained = map['remained'],
        registered = map['registered'];

  register() => registered = true;
  unregister() => registered = false;

  login() {
    if (registered == true) {
      return;
    } else if (remained > 0) {
      remained = remained - 1;
    } else {}
  }

  static String encrypt(String text) {
    String result = "";

    for (var i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i);
      int offset = 0;
      int x = 0;

      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        result += " ";
        continue;
      }
      x = (ch + 3 - offset) % 26;
      result += String.fromCharCode(x + offset);
    }
    return result;
  }

  String decrypt(String text) {
    String result = "";

    for (var i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i);
      int offset = 0;
      int x = 0;

      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        result += " ";
        continue;
      }
      x = (ch - 3 - offset) % 26;
      result += String.fromCharCode(x + offset);
    }
    return result;
  }
}
