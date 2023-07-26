import 'package:flutter/material.dart';
import 'package:nms/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/helpers/category_helper.dart';
import 'package:nms/helpers/priority_helper.dart';
import 'package:nms/helpers/status_helper.dart';

import 'package:nms/constants/database_constant.dart';

const String tableNote = 'notes';
const String columnId = 'id';
const String columnName = 'name';
const String columnCategory = 'category';
const String columnPriority = 'priority';
const String columnStatus = 'status';
const String columnPlanDate = 'planDate';

class NoteHelper {
  static Future<void> createNoteTable(Database database) async{
    await database.execute('''
      CREATE TABLE $tableNote(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,
          $columnCategory INTEGER NOT NULL, 
          $columnPriority INTEGER NOT NULL,
          $columnStatus INTEGER NOT NULL,
          $columnPlanDate TEXT NOT NULL,
          createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          FOREIGN KEY ($columnCategory) REFERENCES $tableCategory(id) ON DELETE CASCADE ON UPDATE NO ACTION,
          FOREIGN KEY ($columnPriority) REFERENCES $tablePriority(id) ON DELETE CASCADE ON UPDATE NO ACTION,
          FOREIGN KEY ($columnStatus) REFERENCES $tableStatus(id) ON DELETE CASCADE ON UPDATE NO ACTION,
          )
    ''');
  }

  static Future<Database> db() async{
    return openDatabase(
        databaseName,
        version: 1,
        onCreate: (Database database, int version) async{
          await createNoteTable(database);
        }
    );
  }

  static Future<int> createNote(Note note) async{
    final db = await NoteHelper.db();
    final id = await  db.insert(tableNote, note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getNotes() async{
    final db = await NoteHelper.db();
    return db.query(tableNote, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getNote(int id) async{
    final db = await NoteHelper.db();
    return db.query(tableNote, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateNote(Note note) async{
    final db = await NoteHelper.db();

    final result = await db.update(tableNote, note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    return result;
  }

  static Future<void> deleteNote(int id) async{
    final db = await NoteHelper.db();
    try{
      db.delete(tableNote, where: 'id = ?', whereArgs: [id]);
    }catch(err){
      debugPrint('Something went wrong when deleting a note: $err');
    }
  }
}