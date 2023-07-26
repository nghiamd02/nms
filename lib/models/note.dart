import 'package:nms/models/category.dart';
import 'package:nms/models/priority.dart';
import 'package:nms/models/status.dart';

class Note {
  final int? id;
  final String? name;
  final Category? category;
  final Priority? priority;
  final Status? status;
  final DateTime? planDate;
  final DateTime? dateCreate;

  static final columns = ["id","name","category","priority","status","planDate","dateCreate"];

  Note(this.id, this.name, this.category, this.priority, this.status, this.planDate, this.dateCreate);

  factory Note.fromMap(Map<String, dynamic> data) {
    return Note(
      data['id'],
      data['name'],
      data['category'],
      data['priority'],
      data['status'],
      data['planDate'],
      data['dateCreate'],
    );
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "category": category,
    "priority": priority,
    "status": status,
    "planDate": status,
    "dateCreate": status,
  };
}