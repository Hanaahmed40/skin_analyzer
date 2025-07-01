import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_planning/api_service/end_points.dart';
import 'package:event_planning/api_service/request_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(EndPoints.predict)
  @MultiPart()
  Future<RequestResponse> predict(@Part(name: 'file') File image);
}
