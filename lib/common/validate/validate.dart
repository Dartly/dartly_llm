abstract class Validate {
  final String message;
  const Validate(this.message);

  bool isValid(Object? value);
}

class NotNull extends Validate {
  const NotNull({String message = "This field cannot be null"})
      : super(message);

  @override
  bool isValid(Object? value) {
    return value != null && value.toString().trim().isNotEmpty;
  }
}

class Length extends Validate {
  final int minLength;
  final int maxLength;

  const Length(this.minLength, this.maxLength,
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

class MaxLen extends Validate {
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

class MinLen extends Validate {
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

class Email extends Validate {
  const Email({String message = "Invalid email format"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value is String) {
      return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
          .hasMatch(value);
    }
    return true;
  }
}

class Mobile extends Validate {
  const Mobile({String message = "Invalid phone number"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value is String) {
      return RegExp(r"^\+?[1-9]\d{1,14}$").hasMatch(value);
    }
    return true;
  }
}

class Str extends Validate {
  const Str({String message = "Must be a string"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    return value is String;
  }
}

class Int extends Validate {
  const Int({String message = "Must be an integer"}) : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    return value is int;
  }
}

class Date extends Validate {
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

class IsTime extends Validate {
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

class InValues extends Validate {
  final List<Object> allowedValues;

  const InValues(this.allowedValues, {String message = "Value is not allowed"})
      : super(message);

  @override
  bool isValid(Object? value) {
    if (value == null || value == "") return true;
    return allowedValues.contains(value);
  }
}
