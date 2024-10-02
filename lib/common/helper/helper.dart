import 'dart:math';

import 'package:vania/vania.dart';

class Helper {
  static String generateRandomNumber() {
    final random = Random();
    int number = random.nextInt(900000) + 100000;
    return number.toString();
  }

  static Future<bool> verifyRegisterCode(String mobile, String code) async {
    final String cacheCode = await getRegisterCode(mobile, code);
    if (cacheCode.isEmpty) {
      return false;
    }
    if (cacheCode == code) {
      await Cache.delete(
        'register:$mobile:$code',
      );
      return true;
    }
    return false;
  }

  static setRegisterCode(String mobile, String code) async {
    await Cache.put(
      'register:$mobile:$code',
      code,
      duration: Duration(minutes: 15),
    );
  }

  static Future<String> getRegisterCode(String mobile, String code) async {
    return await Cache.get(
      'register:$mobile:$code',
    );
  }
}
