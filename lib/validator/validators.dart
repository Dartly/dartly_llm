import 'base_validator.dart';

class NotNull extends BaseValidator {
  const NotNull({String message = "This field cannot be null"})
      : super(message);

  @override
  bool isValid(Object? value) {
    return value != null && value != "";
  }
}

class LengthRange extends BaseValidator {
  final int minLength;
  final int maxLength;

  const LengthRange(this.minLength, this.maxLength,
      {String message = "Length is out of range"})
      : assert(minLength <= maxLength,
            "minLength should be less than or equal to maxLength"),
        super(message);

  @override
  bool isValid(Object? value) {
    if (value is String) {
      int length = value.length;
      return length >= minLength && length <= maxLength;
    }
    return true;
  }
}

class MaxLen extends BaseValidator {
  final int maxLength;

  const MaxLen(this.maxLength, {String message = "Exceeds maximum length"})
      : super(message);

  @override
  bool isValid(Object? value) {
    if (value is String) {
      return value.length <= maxLength;
    }
    return true;
  }
}

class MinLen extends BaseValidator {
  final int minLength;

  const MinLen(this.minLength, {String message = "Below minimum length"})
      : super(message);

  @override
  bool isValid(Object? value) {
    if (value is String) {
      return value.length >= minLength;
    }
    return true;
  }
}

class Email extends BaseValidator {
  const Email({String message = "Invalid email format"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value is String) {
      return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    }
    return true;
  }
}

class Mobile extends BaseValidator {
  const Mobile({String message = "Invalid phone number"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value is String) {
      return RegExp(r"^\+?[1-9]\d{1,14}$").hasMatch(value);
    }
    return true;
  }
}

class Str extends BaseValidator {
  const Str({String message = "Must be a string"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    return value is String;
  }
}

class Int extends BaseValidator {
  const Int({String message = "Must be an integer"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    return value is int;
  }
}

class Date extends BaseValidator {
  const Date({String message = "Must be a valid date"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    if (value is String) {
      try {
        DateTime.parse(value);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}

class IsTime extends BaseValidator {
  const IsTime({String message = "Must be a valid time"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    if (value is String) {
      try {
        DateTime.parse("1970-01-01 $value");
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}

class InValues extends BaseValidator {
  final List<Object> allowedValues;

  const InValues(this.allowedValues, {String message = "Value is not allowed"})
      : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    return allowedValues.contains(value);
  }
}