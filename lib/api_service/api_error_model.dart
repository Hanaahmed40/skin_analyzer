class ApiErrorModel {
  final String error;
  final String? details;
  final int? statusCode;

  const ApiErrorModel({required this.error, this.statusCode, this.details});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      error: json['error'] ?? 'Unknown error occurred',
      statusCode: json['statusCode'],
      details: json['details'],
    );
  }
}
