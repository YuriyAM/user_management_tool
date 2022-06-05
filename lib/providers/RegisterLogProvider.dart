import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';

class RegisterLogProvider {
  static var db = DatabaseProvider.db;
  static var collection = db.collection("register_log");

  static insert(Logger log) async {
    await collection.insertOne(log.toMap());
    return true;
  }
}
