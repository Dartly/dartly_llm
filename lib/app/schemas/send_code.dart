import 'package:dartly_llm/app/schemas/base_schema.dart';

class SendCode extends BaseSchema {
  SendCode({
    required this.mobile,
  });

  final String? mobile;

  factory SendCode.fromJson(Map<String, dynamic> json) {
    return SendCode(
      mobile: json["mobile"],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "mobile": mobile,
    };
  }

  @override
  String toString() {
    return "$mobile, ";
  }

  @override
  Map<String, List<Validator>> rule() {
    return {
      'mobile': [
        NotNull(message: '手机号码不能为空'),
        Mobile(message: '手机号码格式错误'),
      ]
    };
  }
}
