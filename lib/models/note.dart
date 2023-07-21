import 'package:nms/models/category.dart';
import 'package:flutter/scheduler.dart';
import 'package:nms/models/status.dart';

class Note {
  final String? name;
  final Category? category;
  final Priority? priority;
  final Status? status;
  final DateTime? planDate;
  final DateTime? dateCreate;

  Note(
      {required this.name,
      required this.category,
      required this.priority,
      required this.status,
      required this.planDate,
      required this.dateCreate});
}
