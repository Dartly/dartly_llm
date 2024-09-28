import 'package:dartly_llm/route/version/v1.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    V1().register();
  }
}
