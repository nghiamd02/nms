import 'package:nms/models/category.dart';
import 'package:nms/models/priority.dart';
import 'package:nms/models/status.dart';


class Note {
   String? id;
   String? name;
   Category? category;
   Priority? priority;
   Status? status;
   String? planDate;
   DateTime? createAt;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'category': category,
      'priority': priority,
      'status': status,
      'planDate': planDate,
    };
  }
}
