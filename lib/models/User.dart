import 'package:user_management_tool/models/Credentials.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';

class User {
  String username;
  String password;
  bool? privileged;
  bool? enabled;

  User({
    required this.username,
    this.password = "",
    this.privileged = false,
    this.enabled = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'privileged': privileged,
      'enabled': enabled,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        password = map['password'],
        privileged = map['privileged'],
        enabled = map['enabled'];

  enable() => enabled == true ? enabled = false : enabled = true;
  makeAdmin() => privileged == true ? privileged = false : privileged = true;

  update(User u) {
    password = u.password;
    enabled = u.enabled;
  }

  checkCredentials(Credentials creds) =>
      username == creds.username && password == creds.password ? true : false;
}
