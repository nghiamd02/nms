import 'package:sqflite/sqflite.dart';

const String databasePriority = 'priorities.db';
const String tablePriority = 'priorities';
const String idColumn = '_id';
const String titleColumn = 'title';

class Priority {
  int? id;
  String? title;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      titleColumn: title,
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  Priority();

  Priority.fromMap(Map<String, Object?> map) {
    id = map[idColumn] as int?;
    title = map[titleColumn] as String?;
  }
}

class PriorityProvider {
  late Database db;

  Future open() async {
    db = await openDatabase(databasePriority, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
        CREATE TABLE $tablePriority(
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $titleColumn TEXT NOT NULL)
      ''');
        });
  }

  Future<Priority> insert(Priority priority) async {
    open();
    priority.id = await db.insert(tablePriority, priority.toMap());
    return priority;
  }

  Future<Priority?> getPriority(int id) async {
    open();
    List<Map<String, Object?>> maps = await db.query(tablePriority,
        columns: [idColumn, titleColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if(maps.isNotEmpty){
      return Priority.fromMap(maps.first);
    }
    return null;
  }

  Future<int>delete(int id) async{
    open();
    return await db.delete(tablePriority, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int>update(Priority priority) async{
    open();
    return await db.update(tablePriority, priority.toMap(), where: '$idColumn = ?', whereArgs: [priority.id]);
  }

  Future<void> close() async => db.close();
}
