import 'package:event_planning/api_service/api_result.dart';
import 'package:event_planning/api_service/error_handler.dart';
import 'package:flutter/material.dart';

/// Executes a given asynchronous function and handles any errors that occur during its execution.
///
/// This method takes a [function] that returns a [Future] and attempts to execute it.
/// If the function completes successfully, the result is wrapped in an [ApiResult.success] object and returned.
/// If an error occurs during execution, the error is caught, logged using [debugPrint], and
/// an [ApiResult.error] object is returned with the error handled by [ErrorHandler].
///
/// Example usage:
/// ```dart
/// Future<ApiResult<MyData>> result = executeAndHandleErrors(() async {
///   // Your asynchronous code here
/// });
/// ```
///
/// [T] is the type of the result that the function returns.
Future<ApiResult<T>> apiExecuteAndHandleErrors<T>(
  Future Function() function,
) async {
  try {
    return ApiResult.success(await function());
  } catch (error) {
    debugPrint('********* Error in executeAndHandleErrors: $error **********');
    return ApiResult.failure(ApiErrorHandler.handle(error));
  }
}
