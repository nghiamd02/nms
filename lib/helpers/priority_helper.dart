import 'package:flutter/material.dart';
import 'package:nms/models/priority.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';
import 'package:nms/helpers/sql_helper.dart';

const String tablePriority = 'priorities';
const String columnPriorityId = 'priorityId';
const String columnPriorityTitle = 'priorityTitle';

class PriorityHelper {
  static Future<int> createPriority(Priority priority) async {
    final db = await SQLHelper.db();
    final id = await db.insert(tablePriority, priority.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getPriorities() async {
    final db = await SQLHelper.db();
    return db.query(tablePriority, orderBy: '$columnPriorityId');
  }

  static Future<List<Map<String, dynamic>>> getPriority(int id) async {
    final db = await SQLHelper.db();
    return db.query(tablePriority, where: '$columnPriorityId = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updatePriority(Priority priority) async {
    final db = await SQLHelper.db();

    final result = await db.update(tablePriority, priority.toMap(),
        where: '$columnPriorityId = ?', whereArgs: [priority.id]);
    return result;
  }

  static Future<void> deletePriority(int id) async {
    final db = await SQLHelper.db();
    try {
      db.delete(tablePriority, where: '$columnPriorityId = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting a priority: $err');
    }
  }
}
