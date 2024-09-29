import '../../common/excepitons/serve_exception.dart';
import '../../common/validate/validate.dart';

abstract class BasesModel {
  Map<String, dynamic> toJson() {
    return {};
  }

  Map<String, List<Validate>> getValidation();

  List<String> validate() {
    List<String> errors = [];
    var rules = getValidation();

    for (var entry in rules.entries) {
      var fieldValue = toJson()[entry.key];

      for (var rule in entry.value) {
        print(rule.toString());
        if (!rule.isValid(fieldValue)) {
          errors.add(rule.message);
          throw ServeException(message: errors.join(', '));
        }
      }
    }

    return errors; // 返回错误信息列表（如果有的话）
  }
}
