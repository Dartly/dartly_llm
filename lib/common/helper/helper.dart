import 'package:dartly_llm/common/excepitons/api_exception.dart';
import 'package:vania/vania.dart';

class Helper {
  static isMobile(String mobile) {
    final RegExp regex = RegExp(r'^1[3-9]\d{9}$');
    return regex.hasMatch(mobile);
  }
}

