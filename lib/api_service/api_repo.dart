import 'dart:io';

import 'package:event_planning/api_service/api_result.dart';
import 'package:event_planning/api_service/api_service.dart';
import 'package:event_planning/api_service/request_response.dart';
import 'package:event_planning/core/utils/functions/api_execute_and_handle_errors.dart';

class ApiRepo {
  final ApiService _apiService;

  ApiRepo(this._apiService);

  Future<ApiResult<RequestResponse>> predict(File file) {
    return apiExecuteAndHandleErrors(
        () async => await _apiService.predict(file));
  }
}
