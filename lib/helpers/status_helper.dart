import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nms/models/status.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';



const String tableStatus = 'status';
const String columnId = 'id';
const String columnName = 'name';
const String columnDate = 'date';

class StatusHelper {



  static Future<bool> createStatus(Status status) async{
    final db = await DBHelper.db();
    try {
      final id = await  db.insert(tableStatus, status.toMap(), conflictAlgorithm: ConflictAlgorithm.fail);
      return true;
    }
    catch (e) {
      return false;
    }
    }

  static Future<List<Map<String, dynamic>>> getStatusList() async{
    final db = await DBHelper.db();
    return db.query(tableStatus, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getStatus(int id) async{
    final db = await DBHelper.db();
    return db.query(tableStatus, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<bool> updateStatus(Status status) async{
    final db = await DBHelper.db();
try {
  final id = await db.update(tableStatus, status.toMap(), where: 'id = ?',
      whereArgs: [status.id],
      conflictAlgorithm: ConflictAlgorithm.fail);
  return true;
}
catch (e) {
  return false;
}
  }

  static Future<void> deleteStatus(int id) async{
    final db = await DBHelper.db();
    try{
      db.delete(tableStatus, where: 'id = ?', whereArgs: [id]);
    }catch(err){
      debugPrint('Something went wrong when deleting a status: $err');
    }

  }
}