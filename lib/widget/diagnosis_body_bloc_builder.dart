import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/diagnosis_cubit.dart';
import '../cubits/diagnosis_state.dart';
import '../utils/app_colors.dart';
import 'picked_img_bloc_selector.dart';

class DiagnosisBodyBlocBuilder extends StatelessWidget {
  const DiagnosisBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosisCubit, DiagnosisState>(
        buildWhen: (_, current) =>
            current.status == DiagnosisStateStatus.predictLoading ||
            current.status == DiagnosisStateStatus.predictSuccess ||
            current.status == DiagnosisStateStatus.predictFailure,
        builder: (_, state) {
          return state.status == DiagnosisStateStatus.predictLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    CircularProgressIndicator(color: AppColors.primaryLight),
                    Text(
                      "Analyzing... Please wait",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryLight),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    const PickedImgBlocSelector(),
                    SizedBox(height: 20),
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 120,
                      color: AppColors.redColor,
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.home, color: AppColors.whiteColor),
                      label: Text("Back to Home",
                          style: TextStyle(color: AppColors.whiteColor)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
