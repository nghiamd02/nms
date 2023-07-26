class Category {
  int? id;
  String? title;
  String? createAt;

  Category({this.id, this.title, this.createAt});
  Map<String, dynamic> toMap() {
    return {
      'categoryId': id,
      'categoryTitle': title,
      'createAt' : createAt,
    };
  }
}
