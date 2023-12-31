import 'package:sqflite/sqflite.dart';
import '../helpers/category_helper.dart';
import '../helpers/priority_helper.dart';
import '../helpers/status_helper.dart';

const String databaseName = 'nms.db';

class DBHelper {
  static Future<void> createStatusTable(Database database) async {
    const String tableStatus = 'status';
    const String columnStatusId = 'id';
    const String columnStatusName = 'name';
    const String columnStatusDate = 'date';
    await database.execute('''CREATE TABLE $tableStatus(
          $columnStatusId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnStatusName TEXT NOT NULL UNIQUE,
          $columnStatusDate TEXT)''');
  }

  static Future<void> createPriorityTable(Database database) async {
    const String tablePriority = 'priorities';
    const String columnPriorityId = 'id';
    const String columnPriorityName = 'name';
    const String columnPriorityDate = 'date';
    await database.execute('''CREATE TABLE $tablePriority(
          $columnPriorityId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnPriorityName TEXT NOT NULL UNIQUE,
          $columnPriorityDate TEXT NOT NULL)''');
  }

  static Future<void> createCategoryTable(Database database) async {
    const String tableCategory = 'categories';
    const String columnCategoryId = 'id';
    const String columnCategoryName = 'name';
    const String columnCategoryDate = 'date';
    await database.execute('''CREATE TABLE $tableCategory(
          $columnCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnCategoryName TEXT NOT NULL UNIQUE,
          $columnCategoryDate TEXT NOT NULL)''');
  }

  static Future<void> createNotesTable(Database database) async {
    const String tableNote = 'notes';
    const String columnNoteId = 'id';
    const String columnNoteName = 'name';
    const String columnCategory = 'category';
    const String columnPriority = 'priority';
    const String columnStatus = 'status';
    const String columnPlanDate = 'planDate';
    const String columnAccountId = 'accountId';
    const String columnCreateAt = 'createAt';
    await database.execute('''CREATE TABLE $tableNote(
          $columnNoteId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnNoteName TEXT NOT NULL UNIQUE,
          $columnCategory INTEGER NOT NULL,
          $columnPriority INTEGER NOT NULL,
          $columnStatus INTEGER NOT NULL,
          $columnPlanDate TEXT NOT NULL,
          $columnAccountId INTEGER NOT NULL,
          $columnCreateAt TEXT NOT NULL,
          FOREIGN KEY ($columnCategory) REFERENCES $tableCategory($columnCategoryId),
          FOREIGN KEY ($columnPriority) REFERENCES $tablePriority($columnPriorityId),
          FOREIGN KEY ($columnStatus) REFERENCES $tableStatus($columnStatusId))''');
  }

  static Future<void> createAccountTable(Database database) async {
    const accountsTable = 'accounts';
    const columnId = 'id';
    const columnEmail = 'email';
    const columnPassword = 'password';
    const columnFirstName = 'firstName';
    const columnLastName = 'lastName';
    const columnCreateAt = 'date';

    await database.execute('''CREATE TABLE $accountsTable(
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $columnEmail TEXT NOT NULL, 
    $columnPassword TEXT NOT NULL, 
    $columnFirstName TEXT,
    $columnLastName TEXT,
    $columnCreateAt TEXT)''');
  }

  static Future<Database> db() async {
    return openDatabase(databaseName, version: 1,
        onCreate: (Database database, int version) async {
      await createCategoryTable(database);
      await createPriorityTable(database);
      await createStatusTable(database);
      await createNotesTable(database);
      await createAccountTable(database);
    });
  }
}
