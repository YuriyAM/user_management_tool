import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Credentials.dart';

import 'User.dart';

enum OperationalLogAction {
  OPEN_HOME_PAGE,
  OPEN_PASSWORD_PAGE,
  OPEN_ACCOUNT_PAGE,
  OPEN_USER_LIST,
  OPEN_INFO_PAGE,
  IDENTIFICATION_PASSED,
  IDENTIFICATION_FAILED,
  RESTRICTED_ACTION
}
