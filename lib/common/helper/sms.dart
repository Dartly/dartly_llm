import 'package:http/http.dart' as http;

class Sms {
  Future<bool> sendSms(String mobile, String code) async {
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
}
