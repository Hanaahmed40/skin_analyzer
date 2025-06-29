class Tip {
  final String tip;

  Tip({required this.tip});

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      tip: json['tip'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tip': tip,
    };
  }
}
