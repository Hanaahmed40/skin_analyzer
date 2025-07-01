import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/diagnosis_cubit.dart';
import '../cubits/diagnosis_state.dart';
import 'diagnosis_detail_widget.dart';
import 'diagnosis_error_widget.dart';
import 'diagnosis_loading_widget.dart';

class DiagnosisBodyBlocBuilder extends StatelessWidget {
  const DiagnosisBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosisCubit, DiagnosisState>(
      buildWhen: (_, current) => _buildWhen(current.status),
      builder: (_, state) {
        switch (state.status) {
          case DiagnosisStateStatus.fakePredictLoading:
            return const DiagnosisLoadingWidget();
          case DiagnosisStateStatus.fakePredictSuccess:
            return DiagnosisDetailWidget(prediction: state.fakePrediction!);
          case DiagnosisStateStatus.fakePredictFailure:
            return DiagnosisErrorWidget(error: state.errorMessage!);
          default:
            return const DiagnosisLoadingWidget();
        }
      },
    );
  }

  bool _buildWhen(DiagnosisStateStatus status) {
    return status == DiagnosisStateStatus.fakePredictLoading ||
        status == DiagnosisStateStatus.fakePredictSuccess ||
        status == DiagnosisStateStatus.fakePredictFailure;
  }
}
