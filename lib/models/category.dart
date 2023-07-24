// class Category {
//   final int? id;
//   final String? name;
//   final String? date;
//
//   Category({this.id, this.name, this.date});
//
//   Map<String, dynamic> toMap() {
//     return {'id': id, 'name': name, 'date': date};
//   }
// }
import 'package:sqflite/sqflite.dart';

const String databaseCategory = 'categories.db';
const String tableCategory = 'categories';
const String idColumn = '_id';
const String titleColumn = 'title';

class Category {
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

  Category();

  Category.fromMap(Map<String, Object?> map) {
    id = map[idColumn] as int?;
    title = map[titleColumn] as String?;
  }
}

class CategoryProvider {
  late Database db;

  Future open() async {
    db = await openDatabase(databaseCategory, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableCategory(
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $titleColumn TEXT NOT NULL)
      ''');
    });
  }

  Future<Category> insert(Category category) async {
    open();
    category.id = await db.insert(tableCategory, category.toMap());
    return category;
  }

  Future<Category?> getCategory(int id) async {
    open();
    List<Map<String, Object?>> maps = await db.query(tableCategory,
        columns: [idColumn, titleColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if(maps.isNotEmpty){
      return Category.fromMap(maps.first);
    }
    return null;
  }

  Future<int>delete(int id) async{
    open();
    return await db.delete(tableCategory, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int>update(Category category) async{
    open();
    return await db.update(tableCategory, category.toMap(), where: '$idColumn = ?', whereArgs: [category.id]);
  }

  Future<void> close() async => db.close();
}
