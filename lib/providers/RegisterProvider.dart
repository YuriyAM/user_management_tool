import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_management_tool/models/Credentials.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:user_management_tool/models/Registration.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';

class RegisterProvider {
  static var db = DatabaseProvider.db;
  static var collection = db.collection("register");

  static init() async {
    await insert(
      Registration(
        username: "admin",
        registered: true,
        remained: 0,
      ),
    );
    await sync();
  }

  static sync() async {
    final users = await DatabaseProvider.getUsers();
    final regs = [for (User u in users) Registration.fromUser(u)];
    for (Registration reg in regs) {
      await insert(reg);
    }
  }

  static login(User user) async {
    var reg = await find(Registration.fromUser(user));
    if (reg == false) {
      reg = Registration.fromUser(user);
      await insert(reg);
    }

    if (reg.registered == true) {
      return true;
    } else if (reg.remained > 0) {
      reg.remained -= 1;
      await update(reg);
      return true;
    } else {
      return false;
    }
  }

  static registerSoftware(User user, String key) async {
    final reg = await find(Registration.fromUser(user));
    reg.key = Registration.encrypt(key);
    if (await checkRegistration(reg) == true) {
      reg.registered = true;
      await update(reg);
      return true;
    } else {
      return false;
    }
  }

  static checkRegistration(Registration reg) async {
    var r =
        await collection.findOne({"username": reg.username, "key": reg.key});
    return r == null ? false : true;
  }

  static find(Registration reg) async {
    var r = await collection.findOne({"username": reg.username});
    if (r != null) {
      r = Registration.fromMap(r);
    }
    return r ?? false;
  }

  static insert(Registration reg) async {
    if (await find(reg) == false) {
      await collection.insertOne(reg.toMap());
      return true;
    } else {
      return false;
    }
  }

  static update(Registration reg) async {
    await collection.replaceOne({"username": reg.username}, reg.toMap());
    return true;
  }

  static delete(Registration reg) async {
    await collection.remove(where.eq('username', reg.username));
    return true;
  }
}
