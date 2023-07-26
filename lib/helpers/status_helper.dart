import 'package:flutter/material.dart';
import 'package:nms/models/status.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';
import 'package:nms/helpers/sql_helper.dart';

const String tableStatus = 'status';
const String columnStatusId = 'statusId';
const String columnStatusTitle = 'statusTitle';

class StatusHelper {

  static Future<int> createStatus(Status status) async {
    final db = await SQLHelper.db();
    final id = await db.insert(tableStatus, status.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getStatusList() async {
    final db = await SQLHelper.db();
    return db.query(tableStatus, orderBy: '$columnStatusId');
  }

  static Future<List<Map<String, dynamic>>> getStatus(int id) async {
    final db = await SQLHelper.db();
    return db.query(tableStatus, where: '$columnStatusId = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateStatus(Status status) async {
    final db = await SQLHelper.db();

    final result = await db.update(tableStatus, status.toMap(),
        where: '$columnStatusId = ?', whereArgs: [status.id]);
    return result;
  }

  static Future<void> deleteStatus(int id) async {
    final db = await SQLHelper.db();
    try {
      db.delete(tableStatus, where: '$columnStatusId = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting a status: $err');
    }
  }
}
