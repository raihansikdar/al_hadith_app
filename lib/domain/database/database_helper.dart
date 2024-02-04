
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'hadith_bn_test.db');

    final exist = await databaseExists(path);
  
    if(exist){
      log("{===================>Database exist}");
    }else{
      log("{===================>Database not exist}");
    }
    // Check if the database file exists
    if (!await databaseExists(path)) {
      ByteData data = await rootBundle.load('assets/hadith_bn_test.db');
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, version: 1, readOnly: false);

  }
}
