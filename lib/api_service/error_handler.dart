import 'package:dio/dio.dart';
import 'package:event_planning/api_service/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return const ApiErrorModel(error: 'Connection timed out.');
        case DioExceptionType.sendTimeout:
          return const ApiErrorModel(error: 'Send request timed out.');
        case DioExceptionType.receiveTimeout:
          return const ApiErrorModel(error: 'Receive response timed out.');
        case DioExceptionType.badResponse:
          return _handleError(error);
        case DioExceptionType.unknown:
          return _handleError(error);
        case DioExceptionType.cancel:
          return const ApiErrorModel(error: 'Request was cancelled.');
        case DioExceptionType.connectionError:
          return const ApiErrorModel(error: 'No internet connection.');
        case DioExceptionType.badCertificate:
          return const ApiErrorModel(error: 'Certificate error occurred.');
      }
    } else {
      return const ApiErrorModel(error: 'An unexpected error occurred.');
    }
  }

  static ApiErrorModel _handleError(DioException error) {
    if (error.response != null &&
        error.response?.statusCode != null &&
        error.response?.statusMessage != null) {
      return const ApiErrorModel(
        error:
            'Oops! Something went wrong. Don\'t worry these things happen, we are working on it.',
      );
      // return ApiErrorModel.fromJson(error.response!.data);
    } else {
      return const ApiErrorModel(error: 'An unexpected error occurred.');
    }
  }
}
