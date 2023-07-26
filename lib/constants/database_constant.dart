
import 'package:sqflite/sqflite.dart';
const String databaseName = 'nms.db';

class DBHelper {
  static Future<void> createStatusTable(Database database) async{
    const String tableStatus = 'status';
    const String columnId = 'id';
    const String columnName = 'name';
    const String columnDate = 'date';
    await database.execute('''CREATE TABLE $tableStatus(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL UNIQUE,
          $columnDate TEXT NOT NULL)''');
  }

  static Future<void> createPriorityTable(Database database) async{
    const String tablePriority = 'priorities';
    const String columnId = 'id';
    const String columnName = 'name';
    const String columnDate = 'date';
    await database.execute('''CREATE TABLE $tablePriority(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL UNIQUE,
          $columnDate TEXT NOT NULL)''');
  }

  static Future<void> createCategoryTable(Database database) async{
    const String tableCategory = 'categories';
    const String columnId = 'id';
    const String columnName = 'name';
    const String columnDate = 'date';
    await database.execute('''CREATE TABLE $tableCategory(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL UNIQUE,
          $columnDate TEXT NOT NULL)''');
  }
  static Future<Database> db() async{
    return openDatabase(
        databaseName,
        version: 1,
        onCreate: (Database database, int version) async{
          await createCategoryTable(database);
          await createPriorityTable(database);
          await createStatusTable(database);
        }
    );
  }
}