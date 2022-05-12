import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class FileProvider {
  static Future<String> load(String filename) async {
    return await rootBundle.loadString(filename);
  }

  static Future<int> read(String filename) async {
    try {
      final contents = await load(filename);

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
}
