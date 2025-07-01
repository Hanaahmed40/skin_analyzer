import 'dart:io' show File;

import 'package:event_planning/core/supabase/supabase_request_result.dart';
import 'package:event_planning/cubits/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../di.dart';
import '../repositories/main_repo.dart';

class MainCubit extends Cubit<MainState> {
  final MainRepo _mainRepo;
  MainCubit(this._mainRepo) : super(MainState.initial());

  void pickImg(ImageSource source) async {
    final pickedImg = await getIt.get<ImagePicker>().pickImage(source: source);
    if (pickedImg != null) {
      emit(state.copyWith(
        status: MainStateStatus.pickImg,
        pickedImg: File(pickedImg.path),
      ));
    }
  }

  Future<void> fetchRandomTip() async {
    emit(state.copyWith(status: MainStateStatus.fetchRandomTipLoading));
    final result = await _mainRepo.fetchRandomTip();
    switch (result) {
      case SupabaseRequestSuccess(:final data):
        emit(state.copyWith(
          status: MainStateStatus.fetchRandomTipSuccess,
          tip: data,
        ));
      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
          status: MainStateStatus.fetchRandomTipFailure,
          errorMessage: errorModel.message,
        ));
     // default:
       // break;
    }
  }
}
