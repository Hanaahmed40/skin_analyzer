import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/widget/picked_img_bloc_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../main_cubit.dart';
import '../../../main_state.dart';
import '../../../widget/image_picker_bloc_listener.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocSelector<MainCubit, MainState, File?>(
                selector: (state) => state.pickedImg,
                builder: (context, pickedImg) {
                  return pickedImg == null
                      ? Icon(Icons.image_not_supported,
                          size: 150, color: AppColors.greyColor)
                      : PickedImgBlocSelector();
                },
              ),
              const SizedBox(height: 15),
              const ImagePickerBlocListener(),
              ElevatedButton.icon(
                onPressed: () =>
                    context.read<MainCubit>().pickImg(ImageSource.gallery),
                icon: Icon(Icons.photo_library_rounded,
                    color: AppColors.whiteColor),
                label: Text('Pick from Gallery',
                    style: TextStyle(color: AppColors.whiteColor)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () =>
                    context.read<MainCubit>().pickImg(ImageSource.camera),
                icon: Icon(Icons.camera_alt, color: AppColors.whiteColor),
                label: Text('Take a Photo',
                    style: TextStyle(color: AppColors.whiteColor)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
