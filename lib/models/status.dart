import 'package:sqflite/sqflite.dart';
class Status {
  final int? id;
  final String? name;
  final String? date;

  Status({this.id, this.name, this.date});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'date': date};
  }
}


