import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/models/status.dart';

const String tableStatus = 'Status';
const String columnId = 'id';
const String columnTitle = 'name';
// const String columnDate = 'date';

class StatusHelper {
  static Future<void> createStatusTable(Database database) async {
    await database.execute('''CREATE TABLE $tableStatus(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $columnTitle name TEXT
      )''');
  }

  static Future<Database> db() async {
    return openDatabase(
      'nms.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createStatusTable(database);
      },
    );
  }

  static Future<int> createStatus(Status status, refreshJournals) async {
    final db = await StatusHelper.db();

    final id = await db.insert('Status', status.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getStatuses() async {
    final db = await StatusHelper.db();
    return db.query('Status', orderBy: "id");
  }

  static Future<dynamic> getStatus(int id) async {
    final db = await StatusHelper.db();
    return db.query('Status', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateStatus(Status status) async {
    final db = await StatusHelper.db();
    final result = await db.update('Status', status.toMap(),
        where: "id= ?", whereArgs: [status.id]);
    return result;
  }

  static Future<void> deleteStatus(int id) async {
    final db = await StatusHelper.db();
    try {
      await db.delete("Status", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Status: $err");
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:nms/models/status.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:nms/constants/database_constant.dart';
//
// const String tableStatus = 'status';
// const String columnId = 'id';
// const String columnTitle = 'title';
//
// class StatusHelper {
//   static Future<void> createStatusTable(Database database) async{
//     await database.execute('''
//       CREATE TABLE $tableStatus(
//           $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//           $columnTitle TEXT NOT NULL,
//           createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//           )
//     ''');
//   }
//
//   static Future<Database> db() async{
//     return openDatabase(
//         databaseName,
//         version: 1,
//         onCreate: (Database database, int version) async{
//           await createStatusTable(database);
//         }
//     );
//   }
//
//   static Future<int> createStatus(Status status) async{
//     final db = await StatusHelper.db();
//     final id = await  db.insert(tableStatus, status.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//     return id;
//   }
//
//   static Future<List<Map<String, dynamic>>> getStatusList() async{
//     final db = await StatusHelper.db();
//     return db.query(tableStatus, orderBy: 'id');
//   }
//
//   static Future<List<Map<String, dynamic>>> getStatus(int id) async{
//     final db = await StatusHelper.db();
//     return db.query(tableStatus, where: 'id = ?', whereArgs: [id], limit: 1);
//   }
//
//   static Future<int> updateStatus(Status status) async{
//     final db = await StatusHelper.db();
//
//     final result = await db.update(tableStatus, status.toMap(), where: 'id = ?', whereArgs: [status.id]);
//     return result;
//   }
//
//   static Future<void> deleteStatus(int id) async{
//     final db = await StatusHelper.db();
//     try{
//       db.delete(tableStatus, where: 'id = ?', whereArgs: [id]);
//     }catch(err){
//       debugPrint('Something went wrong when deleting a status: $err');
//     }
//
//   }
// }