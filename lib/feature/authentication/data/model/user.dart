class User {
  final String username;
  final String password;
  final String email;
  final String password_confirmation;
  final String solde;
  final int age;

  User(
      {required this.username,
      required this.password,
      required this.email,
      required this.age,
      required this.solde,
      required this.password_confirmation});

  Map<String, dynamic> toJson() {
    return {
      "name": username,
      "email": email,
      "solde": solde,
      "password": password,
      "age": age,
      "password_confirmation": password_confirmation
    };
  }
}
