
class Login   {
  Login({
    required this.email,
    required this.code,
    required this.password,
  });

  final String? email;
  final String? code;
  final String? password;

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
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
