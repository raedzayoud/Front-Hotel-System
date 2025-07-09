class User {
  final String username;
  final String password;
  final String email;
  final String password_confirmation;
  final String phone;

  User(
      {required this.username,
      required this.password,
      required this.email,
      required this.phone,
      required this.password_confirmation});

  Map<String, dynamic> toJson() {
    return {
      "name": username,
      "email": email,
      "phone":phone,
      "password": password,
      "password_confirmation": password_confirmation
    };
  }
}
