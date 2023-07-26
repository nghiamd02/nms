import 'package:flutter/cupertino.dart';
import 'package:nms/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';

const String tableCategory = 'categories';
const String columnId = 'id';
const String columnTitle = 'title';

class CategoryHelper {
  static Future<void> createCategoryTable(Database database) async{
    await database.execute('''
      CREATE TABLE $tableCategory(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnTitle TEXT NOT NULL,
          createAt TEXT
          )
    ''');
  }

  static Future<Database> db() async{
    return openDatabase(
      databaseName,
      version: 1,
      onCreate: (Database database, int version) async{
        await createCategoryTable(database);
      }
    );
  }

  static Future<int> createCategory(Category category) async{
    final db = await CategoryHelper.db();
    final id = await  db.insert(tableCategory, category.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async{
    final db = await CategoryHelper.db();
    return db.query(tableCategory, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getCategory(int id) async{
    final db = await CategoryHelper.db();
    return db.query(tableCategory, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateCategory(Category category) async{
    final db = await CategoryHelper.db();

    final result = await db.update(tableCategory, category.toMap(), where: 'id = ?', whereArgs: [category.id]);
    return result;
  }

  static Future<void> deleteCategory(int id) async{
    final db = await CategoryHelper.db();
    try{
      db.delete(tableCategory, where: 'id = ?', whereArgs: [id]);
    }catch(err){
      debugPrint('Something went wrong when deleting a category: $err');
    }

  }
}