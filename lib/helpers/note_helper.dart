import 'package:flutter/material.dart';
import 'package:nms/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/helpers/sql_helper.dart';


const String tableNote = 'notes';
const String columnNoteId = 'noteId';
const String columnNoteName = 'noteName';
const String columnCategory = 'category';
const String columnPriority = 'priority';
const String columnStatus = 'status';
const String columnPlanDate = 'planDate';
const String columnCreateAt = 'createAt';

class NoteHelper {
  static Future<int> createNote(Note note) async {
    final db = await SQLHelper.db();
    final id = await db.insert(tableNote, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await SQLHelper.db();
    return db.query(tableNote, orderBy: columnNoteId);
  }

  static Future<Map<String, dynamic>> getNote(int id) async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> noteList = await db.query(tableNote, where: '$columnNoteId = ?', whereArgs: [id]);
    return noteList.first;
  }

  static Future<int> updateNote(Note note) async {
    final db = await SQLHelper.db();

    final result = await db
        .update(tableNote, note.toMap(), where: '$columnNoteId = ?', whereArgs: [note.id]);
    return result;
  }

  static Future<void> deleteNote(int id) async {
    final db = await SQLHelper.db();
    try {
      db.delete(tableNote, where: '$columnNoteId = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting a note: $err');
    }
  }
}
