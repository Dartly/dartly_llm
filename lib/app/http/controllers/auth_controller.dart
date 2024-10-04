import 'package:dartly_llm/app/http/services/services.dart';
import 'package:dartly_llm/app/models/dtos/dtos.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  final UserService _userService = UserService();

  ///发送短信验证码
  Future<Response> sendCode(Request req) async {
    final post = SendCodeDto.fromJson(req.toJson());
    post.validate();

    await _userService.sendCode(post);

    return ApiResult.success(
      message: '发送成功',
    );
  }

  ///注册
  Future<Response> register(Request req) async {
    final post = RegisterDto.fromJson(req.toJson());
    post.validate();
    await _userService.register(post);
    return ApiResult.success(
      message: '注册成功',
    );
  }

  ///登录
  Future<Response> login(Request req) async {
    final post = RegisterDto.fromJson(req.toJson());
    post.validate();
    return ApiResult.success(
      data: await _userService.login(post),
      message: '登录成功',
    );
  }
}

final AuthController authController = AuthController();
