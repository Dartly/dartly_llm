import 'package:dartly_llm/app/http/controllers/controllers.dart';
import 'package:vania/vania.dart';

class V1 implements Route {
  @override
  void register() {
    Router.basePrefix('api/v1');
    Router.group(
      () {
        Router.post('login', authController.login);
      },
      prefix: 'auth',
    );
  }
}
