import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:user_management_tool/models/User.dart';

final passwordRegex = RegExp(r'^[a-zA-Z0-9!(),\-.\/:;?\\|]{8,}$');

class Credentials {
  String username;
  String password;

  Credentials({required this.username, required this.password});

  Credentials.fromUser(User u)
      : username = u.username,
        password = u.password;

  hashPassword() => password = sha256.convert(utf8.encode(password)).toString();
}
