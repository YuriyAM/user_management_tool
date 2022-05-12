import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/models/User.dart';

final passwordRegex = RegExp(r'^[a-zA-Z0-9!(),\-.\/:;?\\|]{8,}$');

class Credentials {
  final String username;
  final String password;

  Credentials({required this.username, required this.password});

  Credentials.fromUser(User u)
      : username = u.username,
        password = u.password;

  login() async {}
}
