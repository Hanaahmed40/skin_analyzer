//import 'dart:io' show File;

import 'package:event_planning/core/supabase/supabase_request_result.dart';
import 'package:event_planning/core/utils/app_utils.dart';
import 'package:event_planning/cubits/profile_state.dart';
import 'package:event_planning/di.dart';
import 'package:event_planning/models/auth_params.dart';
import 'package:event_planning/repositories/profile_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(ProfileState.initial());

  final nameController = TextEditingController(text: currentUser!.name);
  final emailController = TextEditingController(text: currentUser!.email);
  final passwordController = TextEditingController();

  void togglePassVisibility() {
    emit(state.copyWith(
      status: ProfileStatus.togglePassVisibility,
      isPassObscure: !state.isPassObscure,
    ));
  }

 void updatePassword() async {
  final password = passwordController.text.trim();

  if (password.length < 6) {
    emit(state.copyWith(
      status: ProfileStatus.updatePassFailure,
      errorMessage: 'Password must be at least 6 characters',
    ));
    return;
  }

  emit(state.copyWith(status: ProfileStatus.updatePassLoading));
  final result = await _profileRepo.updatePassword(AuthParams(
    password: password,
  ));

  switch (result) {
    case SupabaseRequestSuccess(:final data):
      emit(state.copyWith(
        status: ProfileStatus.updatePassSuccess,
        user: data,
      ));
      break;
    case SupabaseRequestFailure(:final errorModel):
      emit(state.copyWith(
        status: ProfileStatus.updatePassFailure,
        errorMessage: errorModel.message,
      ));
      break;
  }
}


  void updateUser() async {
    emit(state.copyWith(status: ProfileStatus.updateUserLoading));
    final result = await _profileRepo.updateProfile(AuthParams(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
    ));
    switch (result) {
      case SupabaseRequestSuccess(:final data):
        emit(state.copyWith(
          status: ProfileStatus.updateUserSuccess,
          user: data,
        ));
        break;
      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
          status: ProfileStatus.updateUserFailure,
          errorMessage: errorModel.message,
        ));
        break;
    //  default:
      //  break;
    }
  }

  void pickImg() async {
    final pickedImg =
        await getIt.get<ImagePicker>().pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      emit(state.copyWith(
        status: ProfileStatus.pickImg,
        pickedImg: pickedImg,
      ));
    }
  }

  void updateProfileImg() async {
    if (state.pickedImg == null) return;
    emit(state.copyWith(status: ProfileStatus.updateImgLoading));
    final result = await _profileRepo.updateProfileImg(state.pickedImg);
    switch (result) {
      case SupabaseRequestSuccess(:final data):
        emit(state.copyWith(
          status: ProfileStatus.updateImgSuccess,
          avatarUrl: data,
        ));
        break;
      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
          status: ProfileStatus.updateImgFailure,
          errorMessage: errorModel.message,
        ));
        break;
    //  default:
      //  break;
    }
  }

  void logout() async {
    emit(state.copyWith(status: ProfileStatus.logoutLoading));
    final result = await _profileRepo.logOut();
    switch (result) {
      case SupabaseRequestSuccess():
        emit(state.copyWith(status: ProfileStatus.logoutSuccess));
        break;
      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
          status: ProfileStatus.logoutFailure,
          errorMessage: errorModel.message,
        ));
        break;
  //    default:
    //    break;
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
