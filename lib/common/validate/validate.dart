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
    return value != null && value != "";
  }
}
