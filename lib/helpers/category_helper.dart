import 'package:flutter/cupertino.dart';
import 'package:nms/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';


const String tableCategory = 'categories';
const String columnId = 'id';
const String columnName = 'name';
const String columnDate = 'date';

class CategoryHelper {

  static Future<bool> createCategory(Category category) async {
    final db = await DBHelper.db();
    try {
      final id = await db.insert(tableCategory, category.toMap(),conflictAlgorithm: ConflictAlgorithm.fail);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getCategories() async{
    final db = await DBHelper.db();
    return db.query(tableCategory, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getCategory(int id) async{
    final db = await DBHelper.db();
    return db.query(tableCategory, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<bool> updateCategory(Category category) async{
    final db = await DBHelper.db();
    try {
      final id = await db.update(
          tableCategory, category.toMap(), where: 'id = ?',whereArgs: [category.id],conflictAlgorithm: ConflictAlgorithm.fail);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  static Future<void> deleteCategory(int id) async{
    final db = await DBHelper.db();
    try{
      db.delete(tableCategory, where: 'id = ?', whereArgs: [id]);
    }catch(err){
      debugPrint('Something went wrong when deleting a category: $err');
    }

  }
}
