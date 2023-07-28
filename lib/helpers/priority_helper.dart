import 'package:flutter/material.dart';
import 'package:nms/models/priority.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';

const String tablePriority = 'priorities';
const String columnPriorityId = 'id';
const String columnPriorityName = 'name';
const String columnPriorityDate = 'date';

class PriorityHelper {
  static Future<bool> createPriority(Priority priority) async {
    final db = await DBHelper.db();
    try {
      final id = await db.insert(tablePriority, priority.toMap(),
          conflictAlgorithm: ConflictAlgorithm.fail);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getPriorities() async {
    final db = await DBHelper.db();
    return db.query(tablePriority, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getPriority(int id) async {
    final db = await DBHelper.db();
    return db.query(tablePriority, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<bool> updatePriority(Priority priority) async {
    final db = await DBHelper.db();
    try {
      final id = await db.update(tablePriority, priority.toMap(),
          where: 'id = ?',
          whereArgs: [priority.id],
          conflictAlgorithm: ConflictAlgorithm.fail);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> deletePriority(int id) async {
    final db = await DBHelper.db();
    try {
      db.delete(tablePriority, where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting a priority: $err');
    }
  }
}

