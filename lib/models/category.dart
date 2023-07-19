class Category {
  final String? title;
  final DateTime? createAt;

  Category({required this.title}) : createAt = DateTime.now();
}