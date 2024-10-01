import 'package:vania/vania.dart';

class ApiException extends BaseHttpResponseException {
  ApiException(
      {super.message,
      super.code = 400,
      super.responseType = ResponseType.json,
      super.errorCode = 'Error'});
}
