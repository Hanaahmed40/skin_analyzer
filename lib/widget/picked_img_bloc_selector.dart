import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/main_cubit.dart';
import '../cubits/main_state.dart';

class PickedImgBlocSelector extends StatelessWidget {
  const PickedImgBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainCubit, MainState, File?>(
      selector: (state) => state.pickedImg,
      builder: (context, pickedImg) => pickedImg == null
          ? const CircleAvatar(
              radius: 120,
              child: Icon(Icons.person, size: 80),
            )
          : CircleAvatar(
              radius: 120,
              backgroundImage: FileImage(pickedImg) as ImageProvider,
            ),
    );
  }
}
