import 'package:dartly_llm/app/models/user.dart';
import 'package:dartly_llm/app/schemas/schemas.dart';
import 'package:dartly_llm/common/excepitons/api_exception.dart';
import 'package:dartly_llm/common/helper/helper.dart';
import 'package:dartly_llm/common/helper/sms.dart';
import 'package:dartly_llm/common/helper/snowflake.dart';

class UserService {
  ///手机号码注册
  Future<void> register(Register post) async {
    final user = await _findUserByMobile(post.mobile!);
    if (user != null) {
      throw ApiException(message: '用户已存在');
    }
    if (!await Helper.verifyRegisterCode(post.mobile!, post.code!)) {
      throw ApiException(message: '验证码错误');
    }

    await User().query().insert({
      'id': Snowflake.instance.nextId(),
      'mobile': post.mobile,
      'username': post.mobile,
    });
  }

  Future<Map<String, dynamic>?> _findUserByMobile(String mobile) async {
    return await User()
        .query()
        .where('mobile', '=', mobile)
        .whereNull('deleted_at')
        .first();
  }

  ///发送手机验证码
  Future<void> sendCode(SendCode post) async {
    final code = Helper.generateRandomNumber();
    if (!await Sms().sendSms(post.mobile!, code)) {
      throw ApiException(message: '验证码发送失败');
    }
    Helper.setRegisterCode(post.mobile!, code);
  }

  Future<Map<String, dynamic>?> _findUserById(String id) async {
    return await User()
        .query()
        .where('id', '=', id)
        .whereNull('deleted_at')
        .first();
  }
}
