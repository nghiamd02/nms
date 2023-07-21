import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'model/category.dart';

class SQLHelper {
  static Future<void> createCategoryTable(Database database) async {
    await database.execute('''CREATE TABLE Category(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      date TEXT
      )''');
  }

  static Future<Database> db() async {
    return openDatabase(
      'demo.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createCategoryTable(database);
      },
    );
  }

  static Future<int> createCategory(Category Category, refreshJournals) async {
    final db = await SQLHelper.db();

    final id = await db.insert('Category', Category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await SQLHelper.db();
    return db.query('Category', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getCategory(int id) async {
    final db = await SQLHelper.db();
    return db.query('Category', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateCategory(Category Category) async {
    final db = await SQLHelper.db();
    final result = await db.update('Category', Category.toMap(),
        where: "id= ?", whereArgs: [Category.id]);
    return result;
  }

  static Future<void> deleteCategory(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Category", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Category: $err");
    }
  }
}
