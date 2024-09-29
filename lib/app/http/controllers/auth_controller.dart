import 'package:dartly_llm/app/schemas/login.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> login(Request req) async {
    req.validate({
      'login.email': 'required|email',
      'login.password': 'required|length_between:8,12',
      'login.code': 'required|numeric',
    }, {
      'login.email.required': '邮箱不能为空',
      'login.email.email': '邮箱格式错误',
      'login.password.required': '密码不能为空',
      'login.password.length_between': '密码长度必须为8-12位',
    });

    final post = Login.fromJson(req.toJson());
    return ApiResult.success();
  }
}

final AuthController authController = AuthController();
