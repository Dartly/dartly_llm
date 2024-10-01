import 'package:vania/vania.dart';

class CreateUsersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTable('users', () {
      bigInt('id', length: 20, comment: 'id');
      string('username', length: 32, nullable: true, comment: '用户名');
      string('avatar', nullable: true, comment: '头像');
      string('email', length: 64, nullable: true, comment: '邮箱');
      string('mobile', length: 11, nullable: true, comment: '手机号码');
      enumType('gender', ['0', '1', '2'],nullable: true,
          defaultValue: '2', comment: '性别:0女 1男 2未知');
      softDeletes('deleted_at');
      timeStamps();
      primary('id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('users');
  }
}
