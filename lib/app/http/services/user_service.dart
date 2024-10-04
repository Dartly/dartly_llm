import 'package:dartly_llm/app/models/dtos/dtos.dart';
import 'package:dartly_llm/app/models/user.dart';
import 'package:dartly_llm/common/enum/enums.dart';
import 'package:dartly_llm/common/excepitons/api_exception.dart';
import 'package:dartly_llm/common/helper/helper.dart';
import 'package:dartly_llm/common/helper/snowflake.dart';
import 'package:random_string/random_string.dart';
import 'package:vania/vania.dart';

class UserService {
  ///发送短信验证码
  Future<void> sendCode(
    SendCodeDto post,
  ) async {
    final code = randomNumeric(6);
    if (!await Helper.instance.sendSms(
      post.mobile!,
      code,
    )) {
      throw ApiException(message: '验证码发送失败');
    }
    await Helper.instance.saveVerificationCade(
      VerificationCode.values[int.parse(post.type!)],
      post.mobile!,
      code,
    );
  }

  ///注册
  Future<void> register(
    RegisterDto post,
  ) async {
    if (!await Helper.instance.verifyCode(
      VerificationCode.Register,
      post.mobile!,
      post.code!,
    )) {
      throw ApiException(message: '验证码错误');
    }
    final user = await _findUserByMobile(post.mobile!);
    if (user != null) {
      throw ApiException(message: '用户已存在');
    }

    await User().query().insert({
      'id': Snowflake.instance.nextId(),
      'mobile': post.mobile,
      'username': post.mobile,
    });
  }

  ///登录
  Future<Map<String, dynamic>> login(RegisterDto post) async {
    if (!await Helper.instance.verifyCode(
      VerificationCode.Login,
      post.mobile!,
      post.code!,
    )) {
      throw ApiException(message: '验证码错误');
    }
    final user = await _findUserByMobile(post.mobile!);
    if (user == null) {
      throw ApiException(message: '用户不存在');
    }

    final token = await Auth().login(user).createToken(
          expiresIn: Duration(hours: 24),
          withRefreshToken: true,
        );
    return {
      'user': user,
      'token': token,
    };
  }

  Future<Map<String, dynamic>?> _findUserByMobile(
    String mobile,
  ) async {
    return await User()
        .query()
        .where('mobile', '=', mobile)
        .whereNull('deleted_at')
        .first();
  }
}
