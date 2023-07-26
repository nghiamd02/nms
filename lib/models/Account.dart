class Account {
  final int? id;
  final String? password;
  final String? email;
  final String? createAt;
  final String? firstName;
  final String? lastName;

  Account(
      {this.id,
      this.password,
      this.email,
      this.createAt,
      this.firstName,
      this.lastName});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
