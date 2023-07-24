import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/models/category.dart';

class CategoryHelper {
  static Future<void> createCategoryTable(Database database) async {
    await database.execute('''CREATE TABLE Category(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      date TEXT
      )''');
  }

  static Future<Database> db() async {
    return openDatabase(
      'category.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createCategoryTable(database);
      },
    );
  }

  static Future<int> createCategory(Category category, refreshJournals) async {
    final db = await CategoryHelper.db();

    final id = await db.insert('Category', category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await CategoryHelper.db();
    return db.query('Category', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getCategory(int id) async {
    final db = await CategoryHelper.db();
    return db.query('Category', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateCategory(Category category) async {
    final db = await CategoryHelper.db();
    final result = await db.update('Category', category.toMap(),
        where: "id= ?", whereArgs: [category.id]);
    return result;
  }

  static Future<void> deleteCategory(int id) async {
    final db = await CategoryHelper.db();
    try {
      await db.delete("Category", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Category: $err");
    }
  }
}
