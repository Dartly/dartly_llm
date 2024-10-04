import 'package:dartly_llm/app/models/dtos/base_dto.dart';

class RegisterDto extends BaseDto {
  RegisterDto({
    required this.mobile,
    required this.code,
  });

  final String? mobile;
  final String? code;

  factory RegisterDto.fromJson(Map<String, dynamic> json) {
    return RegisterDto(
      code: json["code"],
      mobile: json["mobile"],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "mobile": mobile,
    };
  }

  @override
  String toString() {
    return "$code, $mobile, ";
  }

  @override
  Map<String, List<Validator>> rule() {
    return {
      'code': [
        NotNull(message: '验证码不能为空'),
      ],
      'mobile': [
        NotNull(message: '手机号码不能为空'),
        Mobile(message: '手机号码格式错误'),
      ]
    };
  }
}
