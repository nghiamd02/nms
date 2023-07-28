import 'package:sqflite/sqflite.dart';
class Status {
  int? id;
  String? name;

  Status({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      name: json['name'],
    );
  }
}


