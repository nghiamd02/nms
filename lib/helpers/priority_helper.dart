import 'package:flutter/material.dart';
import 'package:nms/models/priority.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';

const String tablePriority = 'priorities';
const String columnId = 'id';
const String columnTitle = 'title';

class PriorityHelper {
  static Future<void> createPriorityTable(Database database) async{
    await database.execute('''
      CREATE TABLE $tablePriority(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnTitle TEXT NOT NULL,
          createAt TEXT
          )
    ''');
  }

  static Future<Database> db() async{
    return openDatabase(
        databaseName,
        version: 1,
        onCreate: (Database database, int version) async{
          await createPriorityTable(database);
        }
    );
  }

  static Future<int> createPriority(Priority priority) async{
    final db = await PriorityHelper.db();
    final id = await  db.insert(tablePriority, priority.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getPriorities() async{
    final db = await PriorityHelper.db();
    return db.query(tablePriority, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getPriority(int id) async{
    final db = await PriorityHelper.db();
    return db.query(tablePriority, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updatePriority(Priority priority) async{
    final db = await PriorityHelper.db();

    final result = await db.update(tablePriority, priority.toMap(), where: 'id = ?', whereArgs: [priority.id]);
    return result;
  }

  static Future<void> deletePriority(int id) async{
    final db = await PriorityHelper.db();
    try{
      db.delete(tablePriority, where: 'id = ?', whereArgs: [id]);
    }catch(err){
      debugPrint('Something went wrong when deleting a priority: $err');
    }
  }
}