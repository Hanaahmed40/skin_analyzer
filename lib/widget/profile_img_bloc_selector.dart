import 'dart:io' show File;

import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/cubits/profile_state.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/widget/profile_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImgBlocSelector extends StatelessWidget {
  const ProfileImgBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        BlocSelector<ProfileCubit, ProfileState, XFile?>(
            selector: (state) => state.pickedImg,
            builder: (_, pickedImg) => pickedImg != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.blueColor,
                    backgroundImage:
                        FileImage(File(pickedImg.path)) as ImageProvider,
                  )
                : const ProfileImg()),
        IconButton.filled(
          style: IconButton.styleFrom(
            iconSize: 16,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const CircleBorder(),
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            context.read<ProfileCubit>().pickImg();
          },
          icon: const Icon(Icons.edit, color: Colors.white),
        ),
      ],
    );
  }
}
