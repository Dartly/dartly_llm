import 'package:dartly_llm/app/models/dtos/base_dto.dart';

class SendCodeDto extends BaseDto {
  SendCodeDto({
    required this.mobile,
    required this.type,
  });

  final String? mobile;
  final String? type;

  factory SendCodeDto.fromJson(Map<String, dynamic> json) {
    return SendCodeDto(
      type: json["type"],
      mobile: json["mobile"],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "mobile": mobile,
    };
  }

  @override
  String toString() {
    return "$type, $mobile, ";
  }

  @override
  Map<String, List<Validator>> rule() {
    return {
      'type': [
        NotNull(message: '类型不能为空'),
      ],
      'mobile': [
        NotNull(message: '手机号码不能为空'),
        Mobile(message: '手机号码格式错误'),
      ]
    };
  }
}
