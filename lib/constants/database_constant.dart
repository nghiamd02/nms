import 'package:sqflite/sqflite.dart';

const String databaseName = 'nms.db';

class DBHelper {
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
      await createAccountTable(database);
    });
  }
}
