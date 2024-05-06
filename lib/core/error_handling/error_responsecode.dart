import '../utils/strings/strings_manager.dart';
import 'error_handler.dart';

class ErrorResponseCode {
  static String checkError(int? code) {
    String newCode = "";
    if (code == ResponseCode.BAD_REQUEST) {
      newCode = StringsManager.badRequestError;
    } else if (code == ResponseCode.CACHE_ERROR) {
      newCode = StringsManager.cacheError;
    } else if (code == ResponseCode.CONNECT_TIMEOUT) {
      newCode = StringsManager.timeoutError;
    } else if (code == ResponseCode.FORBIDDEN) {
      newCode = StringsManager.forbiddenError;
    } else if (code == ResponseCode.NOT_FOUND) {
      newCode = StringsManager.notFoundError;
    } else if (code == ResponseCode.NO_INTERNET_CONNECTION) {
      newCode = StringsManager.noInternetError;
    } else if (code == ResponseCode.NO_CONTENT) {
      newCode = StringsManager.noContent;
    } else if (code == ResponseCode.INTERNAL_SERVER_ERROR) {
      newCode = StringsManager.internalServerError;
    } else if (code == ResponseCode.RECIEVE_TIMEOUT) {
      newCode = StringsManager.timeoutError;
    } else if (code == ResponseCode.SEND_TIMEOUT) {
      newCode = StringsManager.timeoutError;
    } else if (code == ResponseCode.DEFAULT) {
      newCode = StringsManager.defaultError;
    }
    return newCode;
  }
}
