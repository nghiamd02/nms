import 'package:flutter/material.dart';
import 'package:nms/constants/database_constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nms/models/account.dart';

class SQLAccountHelper {
  static late Map<String, dynamic> currentAccount;
  static const accountsTable = 'accounts';
  static const columnId = 'id';
  static const columnEmail = 'email';
  static const columnPassword = 'password';
  static const columnFirstName = 'firstName';
  static const columnLastName = 'lastName';
  static const columnCreateAt = 'createAt';
  static const columnNotes = 'notes';

  //Create new account
  static Future<int> createAccount(Account account) async {
    final db = await DBHelper.db();
    final id = await db.insert(accountsTable, account.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await DBHelper.db();

    return db.query(accountsTable, orderBy: columnId);
  }

  static Future<List<Map<String, dynamic>>> getAccount(int id) async {
    final db = await DBHelper.db();

    return db.query(accountsTable,
        where: "$columnId = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateAccount(Account account) async {
    final db = await DBHelper.db();

    final result = await db.update(accountsTable, account.toMap(),
        where: "$columnId = ?", whereArgs: [account.id]);
    return result;
  }

  static Future<void> deleteAccount(int id) async {
    final db = await DBHelper.db();

    try {
      await db.delete(accountsTable, where: "$columnId = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an account: $err");
    }
  }

  static Future<int> saveUser(String email, String password) async {
    var db = await DBHelper.db();
    var result =
        await db.insert(accountsTable, {email: email, password: password});
    return result;
  }

  static Future<Map<String, dynamic>?> getAccountToSave() async {
    var db = await DBHelper.db();
    var result = await db.query(
      accountsTable,
      columns: [columnId, columnEmail, columnPassword],
    );

    if (result.length > 0) {
      return result.first;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getAccountById(int id) async {
    var db = await DBHelper.db();
    var result = await db.query(
      accountsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  static setCurrentAccount(TextEditingController emailController) async {
    var db = await DBHelper.db();
    List<Map<String, dynamic>> result = await db.query(
      accountsTable,
      where: 'email = ?',
      whereArgs: [emailController.text],
    );

    if (result.isNotEmpty) {
      currentAccount = result.first;
    } else {
      return null;
    }
  }
}
