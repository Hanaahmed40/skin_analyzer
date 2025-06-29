import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/diagnosis_cubit.dart';

class DiagnosisErrorWidget extends StatelessWidget {
  const DiagnosisErrorWidget({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 120,
          ),
          Text(
            error,
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            onPressed: () {
              context.read<DiagnosisCubit>().fetchRandomPrediction();
            },
            label: Text('Retry'),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
