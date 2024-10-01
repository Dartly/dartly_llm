import 'package:dartly_llm/app/http/services/services.dart';
import 'package:dartly_llm/app/schemas/schemas.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  final UserService _userService = UserService();

  ///邮箱注册
  Future<Response> loginByEmail(Request req) async {
    req.validate({
      'email': 'required|email',
      'password': 'required|length_between:8,12',
    }, {
      'email.required': '邮箱不能为空',
      'email.email': '邮箱格式错误',
      'password.required': '密码不能为空',
      'password.length_between': '密码长度必须为8-12位',
    });

    await _userService.registerByEmail(
      RegisterEmail.fromJson(req.toJson()),
    );
    return ApiResult.success();
  }
}

final AuthController authController = AuthController();
