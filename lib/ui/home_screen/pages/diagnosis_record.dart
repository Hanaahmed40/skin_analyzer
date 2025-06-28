import 'dart:io';

class DiagnosisRecord {
  final File image;         // الصورة اللي المستخدم اختارها
  final String result;      // نتيجة التحليل (نص زي "Healthy skin detected")
  final DateTime date;      // وقت التشخيص

  DiagnosisRecord({
    required this.image,
    required this.result,
    required this.date,
  });
}