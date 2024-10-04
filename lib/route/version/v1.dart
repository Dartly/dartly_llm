import 'package:vania/vania.dart';

import '../../app/http/controllers/controllers.dart';

class V1 implements Route {
  @override
  void register() {
    Router.basePrefix('api/v1');
    Router.group(
      () {
        Router.post(
          'send-code',
          authController.sendCode,
        );
        Router.post(
          'register',
          authController.register,
        );
        Router.post(
          'login',
          authController.login,
        );
      },
      prefix: 'auth',
    );
  }
}
