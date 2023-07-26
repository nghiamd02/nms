class Status {
  int? id;
  String? title;
  String? createAt;

  Status({this.id, this.title, this.createAt});

  Map<String, dynamic> toMap() {
    return {
      'statusId': id,
      'statusTitle': title,
      'createAt': createAt,
    };
  }
}
