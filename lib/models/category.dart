class Category {
  int? id;
  String? title;
  String? createAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }


}
