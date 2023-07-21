// <<<<<<< HEAD
// class Status {
//   final int? id;
//   final String? name;
//   final String? date;
//
//   Status({this.id, this.name, this.date});
//
//   Map<String, dynamic> toMap() {
//     return {'id': id, 'name': name, 'date': date};
//   }
// }
// =======
import 'package:sqflite/sqflite.dart';

const String databaseStatus = 'status.db';
const String tableStatus = 'status';
const String idColumn = '_id';
const String titleColumn = 'title';

class Status {
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

  Status();

  Status.fromMap(Map<String, Object?> map) {
    id = map[idColumn] as int?;
    title = map[titleColumn] as String?;
  }
}

class StatusProvider {
  late Database db;

  Future open() async {
    db = await openDatabase(databaseStatus, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
        CREATE TABLE $tableStatus(
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $titleColumn TEXT NOT NULL)
      ''');
        });
  }

  Future<Status> insert(Status status) async {
    open();
    status.id = await db.insert(tableStatus, status.toMap());
    return status;
  }

  Future<Status?> getStatus(int id) async {
    open();
    List<Map<String, Object?>> maps = await db.query(tableStatus,
        columns: [idColumn, titleColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if(maps.isNotEmpty){
      return Status.fromMap(maps.first);
    }
    return null;
  }

  Future<int>delete(int id) async{
    open();
    return await db.delete(tableStatus, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int>update(Status status) async{
    open();
    return await db.update(tableStatus, status.toMap(), where: '$idColumn = ?', whereArgs: [status.id]);
  }

  Future<void> close() async => db.close();
}

class Status {
  final StatusType status;
  final DateTime? createAt;

  Status({required this.status}) : createAt = DateTime.now();
}

enum StatusType {
  processing,
  done,
  pending
}

extension StatusTitle on StatusType {
  String get title {
    switch (this) {
      case StatusType.done:
        return 'Done';
      case StatusType.processing:
        return 'Processing';
      case StatusType.pending:
        return 'Pending';
    }
  }
}
// class Status {
//   final StatusType status;
//   final DateTime? createAt;
//
//   Status({required this.status}) : createAt = DateTime.now();
// }
//
// enum StatusType {
//   processing,
//   done,
//   pending
// }
//
// extension StatusTitle on StatusType {
//   String get title {
//     switch (this) {
//       case StatusType.done:
//         return 'Done';
//       case StatusType.processing:
//         return 'Processing';
//       case StatusType.pending:
//         return 'Pending';
//     }
//   }
// }
