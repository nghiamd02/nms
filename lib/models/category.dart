class Category {
  final int? id;
  final String? name;
  final String? date;

  Category({this.id, this.name, this.date});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'date': date};
  }
}
