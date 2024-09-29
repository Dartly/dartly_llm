import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> login(Request req) async {
    req.validate({
      'email': 'required|email',
      'password': 'required|length_between:8,12',
    }, {
      'email.required': '邮箱不能为空',
      'email.email': '邮箱格式错误',
      'password.required': '密码不能为空',
      'password.length_between': '密码长度必须为8-12位',
    });

    // final post = Login.fromJson(req.toJson());
    return ApiResult.success();
  }
}

final AuthController authController = AuthController();
