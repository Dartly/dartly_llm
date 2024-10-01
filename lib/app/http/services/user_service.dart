import 'package:dartly_llm/app/models/user.dart';
import 'package:dartly_llm/app/schemas/schemas.dart';
import 'package:dartly_llm/common/excepitons/api_exception.dart';
import 'package:dartly_llm/common/helper/helper.dart';
import 'package:dartly_llm/common/helper/snowflake.dart';
import 'package:vania/vania.dart';

class UserService {
  ///手机号码注册
  Future<void> register(Register post) async {
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

  Future<Map<String, dynamic>?> _findUserByMobile(String mobile) async {
    return await User()
        .query()
        .where('mobile', '=', mobile)
        .whereNull('deleted_at')
        .first();
  }

  Future<Map<String, dynamic>?> _findUserById(String id) async {
    return await User()
        .query()
        .where('id', '=', id)
        .whereNull('deleted_at')
        .first();
  }
}
