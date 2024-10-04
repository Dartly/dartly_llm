import 'package:dartly_llm/common/excepitons/api_exception.dart';

abstract class BaseDto {
  Map<String, List<Validator>> rule();

  Map<String, dynamic> toJson() {
    return {};
  }

  Map<String, String?> validate() {
    final input = toJson();
    final validators = rule();
    final Map<String, String?> errors = {};

    for (var entry in validators.entries) {
      final fieldName = entry.key;
      final fieldValidators = entry.value;
      for (var validator in fieldValidators) {
        final errorMessage = validator.validate(input[fieldName]);
        if (errorMessage != null) {
          errors[fieldName] = errorMessage;
          throw ApiException(message: errors[fieldName].toString());
        }
      }
    }

    return errors;
  }
}

abstract class Validator {
  String? validate(String? value);
}

class NotNull implements Validator {
  final String message;

  NotNull({required this.message});

  @override
  String? validate(String? value) {
    return (value == null || value.isEmpty) ? message : null;
  }
}

class Mobile implements Validator {
  final String message;

  Mobile({required this.message});

  @override
  String? validate(String? value) {
    final mobileRegex = RegExp(r'^1[3-9]\d{9}$');
    return (value != null && !mobileRegex.hasMatch(value)) ? message : null;
  }
}

class Email implements Validator {
  final String message;

  Email({required this.message});

  @override
  String? validate(String? value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return (value != null && !emailRegex.hasMatch(value)) ? message : null;
  }
}

class MinLength implements Validator {
  final int minLength;
  final String message;

  MinLength({required this.minLength, required this.message});

  @override
  String? validate(String? value) {
    return (value != null && value.length < minLength) ? message : null;
  }
}

class MaxLength implements Validator {
  final int maxLength;
  final String message;

  MaxLength({required this.maxLength, required this.message});

  @override
  String? validate(String? value) {
    return (value != null && value.length > maxLength) ? message : null;
  }
}

class Range implements Validator {
  final int min;
  final int max;
  final String message;

  Range({required this.min, required this.max, required this.message});

  @override
  String? validate(String? value) {
    final intValue = int.tryParse(value ?? '');
    if (intValue == null || intValue < min || intValue > max) {
      return message;
    }
    return null;
  }
}
