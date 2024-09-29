import 'package:dartly_llm/app/schemas/login.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> login(Request req) async {
    final post = Login.fromJson(req.toJson());
    post.validate(post);
    return ApiResult.success();
  }
}

final AuthController authController = AuthController();
