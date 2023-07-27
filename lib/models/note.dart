class Note {
  int? id;
  String? name;
  int? category;
  int? priority;
  int? status;
  String? planDate;
  String? createAt;

  Note(
      {this.id,
      this.name,
      this.category,
      this.priority,
      this.status,
      this.planDate,
      this.createAt});

  Map<String, dynamic> toMap() {
    return {
      'noteId': id,
      'noteName': name,
      'category': category,
      'priority': priority,
      'status': status,
      'planDate': planDate,
      'createAt': createAt,
    };
  }
}
