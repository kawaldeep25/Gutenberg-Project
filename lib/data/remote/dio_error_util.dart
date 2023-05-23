import 'package:dio/dio.dart';
import 'package:guten/utils/constants/constants.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static String handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription = Constants.No_INTERNET_ISSUES;
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          if (error.response?.statusCode == 400) {
            errorDescription = errorDescription =
                '"UnAuthorized", "Session expired! Please login Again';
          } else {
            errorDescription = errorDescription = '404 not found';
          }

          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
