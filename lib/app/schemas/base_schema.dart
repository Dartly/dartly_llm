import 'package:dartly_llm/common/excepitons/serve_exception.dart';

import '../../common/validator/validator.dart';

abstract class BaseSchema {
  void validate() {
    final data = toJson();

    final _strategies = validatorRule();
    for (var entry in data.entries) {
      final strategy = _strategies?[entry.key];
      if (strategy != null && !strategy.validate(entry.value)) {
        throw ServeException(message: strategy.getMessage());
      }
    }
  }

  Map<String, dynamic> toJson() => {};
  Map<String, ValidationStrategy>? validatorRule() {
    return {};
  }
}
