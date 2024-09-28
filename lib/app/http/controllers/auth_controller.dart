import 'package:dartly_llm/validator/validator_factory.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> login(Request req) async {
    ValidatorFactory.validate(req.toJson());
    return ApiResult.success();
  }
}

final AuthController authController = AuthController();
