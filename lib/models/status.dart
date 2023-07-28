class Status {
  int? id;
  String? name;
  String? date;

  Status({this.id, this.name, this.date});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'date': date};
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      name: json['name'],
      date: json['date'],
    );
  }
}


