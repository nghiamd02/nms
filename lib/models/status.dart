class Status {
  final String? title;
  final DateTime? createAt;

  Status({required this.title}) : createAt = DateTime.now();
}