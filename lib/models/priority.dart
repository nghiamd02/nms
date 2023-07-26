class Priority {
  int? id;
  String? title;
  String? createAt;

  Priority({this.id, this.title, this.createAt});
  Map<String, dynamic> toMap() {
    return {'priorityId': id, 'priorityTitle': title, 'createAt': createAt};
  }
}
