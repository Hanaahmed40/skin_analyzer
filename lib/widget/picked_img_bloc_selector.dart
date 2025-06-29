import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main_cubit.dart';
import '../main_state.dart';

class PickedImgBlocSelector extends StatelessWidget {
  const PickedImgBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainCubit, MainState, File?>(
      selector: (state) => state.pickedImg,
      builder: (context, pickedImg) => CircleAvatar(
        radius: 64,
        backgroundImage: FileImage(pickedImg!) as ImageProvider,
      ),
    );
  }
}
