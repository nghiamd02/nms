class Note {
  int? id;
  String? name;
  int? category;
  int? priority;
  int? status;
  String? planDate;
  String? createAt;

  Note({this.id, this.name, this.category, this.priority, this.status, this.planDate, this.createAt});

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

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      priority: json['priority'],
      status: json['status'],
      planDate: json['planDate']
    );
  }
}