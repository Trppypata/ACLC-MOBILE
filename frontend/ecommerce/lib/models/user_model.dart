class User {
  final String email;
  final String password;
  final String? name;
  final String? number;

  User({required this.email, required this.password, this.name, this.number});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      if (name != null) 'name': name,
      if (number != null) 'number': number,
    };
  }
}
