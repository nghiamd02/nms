import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/models/status.dart';

class StatusHelper {
  static Future<void> createStatusTable(Database database) async {
    await database.execute('''CREATE TABLE Status(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      date TEXT
      )''');
  }

  static Future<Database> db() async {
    return openDatabase(
      'status.db',
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

  static Future<List<Map<String, dynamic>>> getStatus(int id) async {
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