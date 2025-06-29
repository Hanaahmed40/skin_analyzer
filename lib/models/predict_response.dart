class PredictResponse {
  final String disease,
      severity,
      description,
      recommendation,
      suggestedTreatment;
  final double confidence;

  PredictResponse({
    required this.disease,
    required this.severity,
    required this.description,
    required this.recommendation,
    required this.suggestedTreatment,
    required this.confidence,
  });

  factory PredictResponse.fromJson(Map<String, dynamic> json) {
    return PredictResponse(
      disease: json['disease'],
      severity: json['severity'],
      description: json['description'],
      recommendation: json['recommendation'],
      suggestedTreatment: json['suggested_treatment'],
      confidence: json['confidence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease': disease,
      'severity': severity,
      'description': description,
      'recommendation': recommendation,
      'suggested_treatment': suggestedTreatment,
      'confidence': confidence,
    };
  }
}
