import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class PredictDetailItem extends StatelessWidget {
  const PredictDetailItem({
    super.key,
    required this.title,
    required this.detail,
  });

  final String title, detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(title),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppColors.blueColor,
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            detail,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
