import 'package:event_planning/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener;

import '../core/router/routes.dart';
import 'package:event_planning/cubits/main_cubit.dart';
import 'package:event_planning/cubits/main_state.dart';



class ImagePickerBlocListener extends StatelessWidget {
  const ImagePickerBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listenWhen: (_, state) => state.status == MainStateStatus.pickImg,
      listener: (_, current) {
        if (current.pickedImg != null) {
          context.pushNamed(Routes.diagnosis);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
