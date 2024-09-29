import '../../common/excepitons/serve_exception.dart';
import '../../common/validate/validate.dart';

abstract class BasesModel {
  Map<String, dynamic> toJson() {
    return {};
  }

  Map<String, List<Validate>> getValidation();

  List<String> validate() {
  List<String> errors = [];
  var rules =getValidation();

  for (var entry in rules.entries) {
    var fieldValue =toJson()[entry.key];

    // 处理每个校验规则
    for (var rule in entry.value) {
      if (!rule.isValid(fieldValue)) {
    
        errors.add(rule.message);
      }
    }
  }

  // 抛出异常并合并错误信息
  if (errors.isNotEmpty) {
    throw ServeException(message: errors.join(', '));
  }

  return errors; // 返回错误信息列表（如果有的话）
}

}
