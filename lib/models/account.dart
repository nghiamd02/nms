class Account {
  final int? id;
  final String? password;
  final String? email;
  final String? createAt;
  final String? firstName;
  final String? lastName;
  final String? date;
  final List<int>? notes;

  Account(
      {this.id,
      this.password,
      this.email,
      this.createAt,
      this.firstName,
      this.lastName,
      this.date,
      this.notes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'notes': notes,
      'date': date,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      password: json['password'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      notes: json['notes'],
      date: json['date'],
    );
  }
}
