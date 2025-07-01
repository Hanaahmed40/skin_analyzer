class RequestResponse {
  final List<Prediction> predictions;

  RequestResponse({required this.predictions});

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return RequestResponse(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predictions': predictions.map((e) => e.toJson()).toList(),
    };
  }
}

class Prediction {
  final String disease,
      description,
      severity,
      recommendation,
      suggestedTreatment;
  final double confidence;

  Prediction({
    required this.disease,
    required this.description,
    required this.severity,
    required this.recommendation,
    required this.suggestedTreatment,
    required this.confidence,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      disease: json['disease'],
      description: json['description'],
      severity: json['severity'],
      recommendation: json['recommendation'],
      suggestedTreatment: json['suggested_treatment'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease': disease,
      'description': description,
      'severity': severity,
      'recommendation': recommendation,
      'suggested_treatment': suggestedTreatment,
      'confidence': confidence,
    };
  }
}
