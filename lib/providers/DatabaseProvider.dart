import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Credentials.dart';
import 'package:yaml/yaml.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:user_management_tool/models/User.dart';

class DatabaseProvider {
  static var db, userCollection;

  // MongoDatabase({
  //   File configFile = File('pubspec.yaml');
  //   String yamlString = configFile.readAsStringSync();
  //   Map yaml = loadYaml(yamlString);
  // });

  static init() async {
    await connect();
    userCollection = db.collection("users");
    await insertUser(
      User(
        username: "admin",
        privileged: true,
        enabled: true,
      ),
    );
  }

  static connect() async {
    final dbUser = dotenv.get("MONGO_USER");
    final dbPassword = dotenv.get("MONGO_PASSWORD");
    final dbHost = dotenv.get("MONGO_HOST");
    final dbPort = dotenv.get("MONGO_PORT");
    final dbName = dotenv.get("MONGO_DATABASE");
    db = await Db.create(
      "mongodb://$dbUser:$dbPassword@$dbHost:$dbPort/$dbName",
    );
    await db.open();
  }

  static findUser(User user) async {
    var u = await userCollection.findOne({"username": user.username});
    if (u != null) {
      u = User.fromMap(u);
    }
    return u ?? false;
  }

  static checkCredentials(Credentials creds) async {
    var u = await userCollection.findOne({
      "username": creds.username,
      "password": creds.password,
    });
    if (u != null) {
      u = User.fromMap(u);
    }
    return u ?? false;
  }

  static Future<List<dynamic>> getUsers() async {
    var users = await userCollection.find().toList();
    if (users != null) {
      users = [for (var map in users) User.fromMap(map)];
    }
    return users ?? false;
  }

  static insertUser(User user) async {
    if (await findUser(user) == false) {
      await userCollection.insertOne(user.toMap());
      return true;
    } else {
      return false;
    }
  }

  static updateUser(User user) async {
    await userCollection.replaceOne({"username": user.username}, user.toMap());
    return true;
  }

  static deleteUser(User user) async {
    await userCollection.remove(where.eq('username', user.username));
    return true;
  }
}
