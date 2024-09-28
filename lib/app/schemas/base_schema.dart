import 'dart:math';

import 'package:dartly_llm/common/excepitons/serve_exception.dart';
import 'package:vania/vania.dart';

import '../../common/validator/validator.dart';

abstract class BaseSchema {
  void validate() {
    final data = toJson();

    final _strategies = validatorRule();
    for (var entry in data.entries) {
      final strategy = _strategies?[entry.key];
      if (strategy != null && !strategy.validate(entry.value)) {
        throw BaseHttpResponseException(
            message: strategy.getMessage(), code: 400, errorCode: '');
      }
    }
  }

  Map<String, dynamic> toJson() => {};
  Map<String, ValidationStrategy>? validatorRule() {
    return {};
  }
}
