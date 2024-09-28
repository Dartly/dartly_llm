abstract class BaseValidator {
  final String message;
  const BaseValidator(this.message);

  bool isValid(Object? value);
}
