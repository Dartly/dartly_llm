import 'package:dartly_llm/app/models/user.dart';
import 'package:dartly_llm/app/schemas/schemas.dart';
import 'package:dartly_llm/common/excepitons/serve_exception.dart';
import 'package:dartly_llm/common/helper/snowflake.dart';
import 'package:vania/vania.dart';

class UserService {
  ///邮箱注册
  Future<void> registerByEmail(RegisterEmail post) async {
    final user = await _findUserByEmail(post.email!);
    if (user != null) {
      throw ApiException(message: '用户已经存在');
    }
    await User().query().insert({
      'id': Snowflake.instance.nextId(),
      'email': post.email,
      'username': post.email,
      'password': Hash().make(post.password!),
    });
  }

  Future<Map<String, dynamic>?> _findUserByEmail(String email) async {
    return await User()
        .query()
        .where('email', '=', email)
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
