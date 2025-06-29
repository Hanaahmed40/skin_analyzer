import 'dart:io' show File;

import 'package:event_planning/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'di.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.initial());

  void pickImg(ImageSource source) async {
    final pickedImg = await getIt.get<ImagePicker>().pickImage(source: source);
    if (pickedImg != null) {
      emit(state.copyWith(
        status: MainStateStatus.pickImg,
        pickedImg: File(pickedImg.path),
      ));
    }
  }
}
