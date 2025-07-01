class ApiErrorModel {
  final String error;
  final int? statusCode;

  const ApiErrorModel({required this.error, this.statusCode});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      error: json['error'] ?? 'Unknown error occurred',
      statusCode: json['statusCode'],
    );
  }
}
