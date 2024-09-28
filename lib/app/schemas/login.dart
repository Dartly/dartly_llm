import 'package:dartly_llm/app/schemas/base_schema.dart';
import 'package:dartly_llm/common/validator/validator.dart';

class Login extends BaseSchema {
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

  @override
  Map<String, ValidationStrategy>? validatorRule() {
    return {
      "email": EmailStrategy(),
      "code": LengthStrategy(6, 6, message: '长度必须为6'),
      "password": LengthStrategy(8, 12),
    };
  }
}
