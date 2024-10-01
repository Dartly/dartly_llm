import 'package:dartly_llm/app/http/services/services.dart';
import 'package:dartly_llm/app/schemas/schemas.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  final UserService _userService = UserService();

  ///邮箱注册
  Future<Response> register(Request req) async {
    req.validate({
      'code': 'required',
      'mobile': 'required|length_between:11,11',
    }, {
      'email.required': '邮箱不能为空',
      'mobile.required': '密码不能为空',
      'mobile.length_between': '手机号码格式错误',
    });

    await _userService.register(
      Register.fromJson(req.toJson()),
    );

    return ApiResult.success(
      message: '注册成功',
    );
  }
}

final AuthController authController = AuthController();
