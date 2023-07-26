import 'package:nms/helpers/status_helper.dart';
import 'package:nms/helpers/priority_helper.dart';
import 'package:nms/helpers/category_helper.dart';
import 'package:nms/helpers/note_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/constants/database_constant.dart';


class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS  $tableCategory(
          $columnCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnCategoryTitle TEXT NOT NULL,
          createAt TEXT
          )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS  $tablePriority(
          $columnPriorityId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnPriorityTitle TEXT NOT NULL,
          createAt TEXT
          )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS  $tableStatus(
          $columnStatusId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnStatusTitle TEXT NOT NULL,
          createAt TEXT
          )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS  $tableNote(
          $columnNoteId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnNoteName TEXT NOT NULL,
          $columnCategory INTEGER NOT NULL,
          $columnPriority INTEGER NOT NULL,
          $columnStatus INTEGER NOT NULL,
          $columnPlanDate TEXT NOT NULL,
          createAt TEXT,
          FOREIGN KEY ($columnCategory) REFERENCES $tableCategory($columnCategoryId),
          FOREIGN KEY ($columnPriority) REFERENCES $tablePriority($columnPriorityId),
          FOREIGN KEY ($columnStatus) REFERENCES $tableStatus($columnStatusId)
          )
    ''');
  }

  static Future<Database> db() async {
    return openDatabase(databaseName, version: 1,
        onCreate: (Database database, int version) async {
          await createTables(database);
        },
    );
  }

}
