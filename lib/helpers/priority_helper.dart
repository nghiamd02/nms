import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/models/priority.dart';

class PriorityHelper {
  static Future<void> createPriorityTable(Database database) async {
    await database.execute('''CREATE TABLE Priority(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      date TEXT
      )''');
  }

  static Future<Database> db() async {
     return openDatabase(
      'priority.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createPriorityTable(database);
      },
    );
  }

  static Future<int> createPriority(Priority priority, refreshJournals) async {
    final db = await PriorityHelper.db();

    final id = await db.insert('Priority', priority.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getPriorities() async {
    final db = await PriorityHelper.db();
    return db.query('Priority', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getPriority(int id) async {
    final db = await PriorityHelper.db();
    return db.query('Priority', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updatePriority(Priority priority) async {
    final db = await PriorityHelper.db();
    final result = await db.update('Priority', priority.toMap(),
        where: "id= ?", whereArgs: [priority.id]);
    return result;
  }

  static Future<void> deletePriority(int id) async {
    final db = await PriorityHelper.db();
    try {
      await db.delete("Priority", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Priority: $err");
    }
  }
}