import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> login() async {
    return ApiResult.success();
  }
}

final AuthController authController = AuthController();
