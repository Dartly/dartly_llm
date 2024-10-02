import 'package:dartly_llm/app/http/services/services.dart';
import 'package:dartly_llm/app/schemas/schemas.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  final UserService _userService = UserService();

  ///邮箱注册
  Future<Response> register(Request req) async {
    final post = Register.fromJson(req.toJson());
    post.validate();
    await _userService.register(post);

    return ApiResult.success(
      message: '注册成功',
    );
  }

  ///发送手机验证码
  Future<Response> sendCode(Request req) async {
    final post = SendCode.fromJson(req.toJson());
    post.validate();
    await _userService.sendCode(post);

    return ApiResult.success(
      message: '发送成功',
    );
  }
}

final AuthController authController = AuthController();
