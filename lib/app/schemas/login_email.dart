
class LoginEmail   {
  LoginEmail({
    required this.email,
    required this.code,
    required this.password,
  });

  final String? email;
  final String? code;
  final String? password;

  factory LoginEmail.fromJson(Map<String, dynamic> json) {
    return LoginEmail(
      email: json["email"],
      code: json["code"],
      password: json["password"],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "code": code,
      "password": password,
    };
  }

  @override
  String toString() {
    return "$email, $code, $password, ";
  }
}
