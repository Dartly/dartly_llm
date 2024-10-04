import 'package:dartly_llm/common/enum/enums.dart';
import 'package:http/http.dart' as http;
import 'package:vania/vania.dart';

class Helper {
  Helper._internal();

  static final Helper instance = Helper._internal();

  factory Helper() {
    return instance;
  }

  ///发送短信验证码
  Future<bool> sendSms(
    String mobile,
    String code,
  ) async {
    final url = 'http://106.ihuyi.com/webservice/sms.php?method=Submit';
    final Map<String, String> values = {
      'account': 'C60941421',
      'password': '5529d681ad901d20d7e1eb75df93711b',
      'mobile': mobile,
      'content': '您的验证码是：${code}。请不要把验证码泄露给其他人。',
      'format': 'json',
    };
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: values,
    );
    return response.statusCode == 200;
  }

  ///缓存验证码
  Future<void> saveVerificationCade(
    VerificationCode type,
    String mobile,
    String code,
  ) async {
    await Cache.put(
      '${type.name}:$mobile:$code',
      code,
      duration: Duration(minutes: 15),
    );
  }

  ///校验验证码
  Future<bool> verifyCode(
    VerificationCode type,
    String mobile,
    String code,
  ) async {
    if (!await Cache.has('${type.name}:$mobile:$code')) {
      return false;
    }
    await Cache.delete('${type.name}:$mobile:$code');
    return true;
  }
}
