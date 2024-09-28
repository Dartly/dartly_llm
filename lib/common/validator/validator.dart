abstract class ValidationStrategy {
  bool validate(String value);
  String? getMessage();
}

class NotEmptyStrategy implements ValidationStrategy {
  final String? message;

  NotEmptyStrategy({this.message = "参数不能为空"});

  @override
  bool validate(String value) {
    return value.isNotEmpty;
  }

  @override
  String? getMessage() {
    return message;
  }
}

class EmailStrategy implements ValidationStrategy {
  final String? message;

  EmailStrategy({this.message = "邮箱格式错哦五"});

  @override
  bool validate(String value) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
  }

  @override
  String? getMessage() {
    return message;
  }
}

class LengthStrategy implements ValidationStrategy {
  final int minLength;
  final int maxLength;
  String? message;

  LengthStrategy(this.minLength, this.maxLength, {this.message}) {
    if (message == null) {
      this.message = "长度必须在 $minLength 到 $maxLength 之间";
    }
  }
  @override
  bool validate(String value) {
    return value.length >= minLength && value.length <= maxLength;
  }

  @override
  String? getMessage() {
    return message;
  }
}

class MobileStrategy implements ValidationStrategy {
  final String? message;

  MobileStrategy({this.message = "手机号格式错误"});

  @override
  bool validate(String value) {
    return RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value);
  }

  @override
  String? getMessage() {
    return message;
  }
}

class MinValueStrategy implements ValidationStrategy {
  final int minValue;
  final String? message;

  MinValueStrategy({required this.minValue, this.message});

  @override
  bool validate(String value) {
    final intValue = int.tryParse(value);
    return intValue != null && intValue >= minValue;
  }

  @override
  String? getMessage() {
    return message ?? "值必须大于或等于 $minValue";
  }
}

class MaxValueStrategy implements ValidationStrategy {
  final int maxValue;
  final String? message;

  MaxValueStrategy({required this.maxValue, this.message});

  @override
  bool validate(String value) {
    final intValue = int.tryParse(value);
    return intValue != null && intValue <= maxValue;
  }

  @override
  String? getMessage() {
    return message ?? "值必须小于或等于 $maxValue";
  }
}

class EnumValueStrategy implements ValidationStrategy {
  final List<String> allowedValues;
  final String? message;

  EnumValueStrategy({required this.allowedValues, this.message});

  @override
  bool validate(String value) {
    return allowedValues.contains(value);
  }

  @override
  String? getMessage() {
    return message ?? "值必须是 ${allowedValues.join(', ')} 中的一个";
  }
}
