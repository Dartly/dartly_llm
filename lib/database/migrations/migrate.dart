import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import '/cloudide/workspace/Dart/dartly_llm/lib/database/migrations/create_personal_access_tokens_table.dartcreate_personal_access_tokens_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async{
		 await CreatePersonalAccessTokensTable().up();
		await CreateUsersTable().up();
	}

  dropTables() async {
		 await CreateUsersTable().down();
		 
	 }
}
