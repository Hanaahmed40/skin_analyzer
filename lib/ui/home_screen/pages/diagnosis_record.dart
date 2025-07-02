class DiagnosisRecord {
  final String imageUrl;
  final String result;
  final DateTime date;

  DiagnosisRecord({
    required this.imageUrl,
    required this.result,
    required this.date,
  });

  factory DiagnosisRecord.fromJson(Map<String, dynamic> json) {
    return DiagnosisRecord(
      imageUrl: json['image_url'],
      result: json['disease'],
      date: DateTime.parse(json['created_at']),
    );
  }
}