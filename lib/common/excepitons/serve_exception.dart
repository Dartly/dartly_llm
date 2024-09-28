
import 'package:vania/vania.dart';

class  ServeException extends BaseHttpResponseException{

    ServeException(
      { super.message,
       super.code=400,
      super.responseType = ResponseType.json,
      super.errorCode = 'Error'});
}