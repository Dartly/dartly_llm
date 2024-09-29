import '../../common/excepitons/serve_exception.dart';
import '../../common/validate/validate.dart';

abstract class BasesModel {
  Map<String, dynamic> toJson() {
    return {};
  }

  Map<String, List<Validate>> getValidation();

  List<String> validate(BasesModel obj) {
    List<String> errors = [];

    var rules = obj.getValidation();

    for (var entry in rules.entries) {
      var fieldValue = obj.toJson()[entry.key];
      for (var rule in entry.value) {
        if (!rule.isValid(fieldValue)) {
          errors.add(rule.message);
        }
      }
    }

    if (errors.isNotEmpty) {
      throw ServeException(message: errors.first);
    }

    return errors;
  }
}
