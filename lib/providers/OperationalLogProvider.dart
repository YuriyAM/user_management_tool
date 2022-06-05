import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';

class OperationalLogProvider {
  static var db = DatabaseProvider.db;
  static var collection = db.collection("operational_log");

  static insert(Logger log) async {
    await collection.insertOne(log.toMap());
    return true;
  }
}
