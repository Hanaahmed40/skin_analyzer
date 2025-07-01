import 'package:event_planning/models/user_model.dart';
import 'package:image_picker/image_picker.dart' show XFile;

enum ProfileStatus {
  initial,
  updateUserLoading,
  updateUserSuccess,
  updateUserFailure,
  updateImgLoading,
  updateImgSuccess,
  updateImgFailure,
  logoutLoading,
  logoutSuccess,
  logoutFailure,
  togglePassVisibility,
  pickImg,
  updatePassLoading,
  updatePassSuccess,
  updatePassFailure,
}

class ProfileState {
  final ProfileStatus status;
  final UserModel? user;
  final String? errorMessage, avatarUrl;
  final bool isPassObscure;
  final XFile? pickedImg;

  ProfileState({
    required this.status,
    this.user,
    this.errorMessage,
    this.avatarUrl,
    this.isPassObscure = true,
    this.pickedImg,
  });

  factory ProfileState.initial() => ProfileState(status: ProfileStatus.initial);

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? user,
    String? errorMessage,
    String? avatarUrl,
    bool? isPassObscure,
    XFile? pickedImg,
  }) =>
      ProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        isPassObscure: isPassObscure ?? this.isPassObscure,
        pickedImg: pickedImg ?? this.pickedImg,
      );
}
