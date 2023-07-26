import 'package:flutter/cupertino.dart';
import 'package:nms/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/helpers/sql_helper.dart';

const String tableCategory = 'categories';
const String columnCategoryId = 'categoryId';
const String columnCategoryTitle = 'categoryTitle';

class CategoryHelper {
  static Future<int> createCategory(Category category) async {
    final db = await SQLHelper.db();
    final id = await db.insert(tableCategory, category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await SQLHelper.db();
    return db.query(tableCategory, orderBy: '$columnCategoryId');
  }

  static Future<List<Map<String, dynamic>>> getCategory(int id) async {
    final db = await SQLHelper.db();
    return db.query(tableCategory, where: '$columnCategoryId = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateCategory(Category category) async {
    final db = await SQLHelper.db();

    final result = await db.update(tableCategory, category.toMap(),
        where: '$columnCategoryId = ?', whereArgs: [category.id]);
    return result;
  }

  static Future<void> deleteCategory(int id) async {
    final db = await SQLHelper.db();
    try {
      db.delete(tableCategory, where: '$columnCategoryId = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting a category: $err');
    }
  }
}
