import 'package:dartly_llm/common/validate/validate.dart';

import 'bases_model.dart';

class Login extends BasesModel {
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

  @override
  Map<String, List<Validate>> getValidation() {
    return {
      'password': [
        const NotNull(message: '密码不能为空'),
        const Length(8, 12, message: '密码长度为8-12')
      ],
      "email": [const NotNull(message: '邮箱不能为空'), Email(message: '邮箱格式错误')]
    };
  }

  @override
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
