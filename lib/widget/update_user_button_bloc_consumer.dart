import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/core/utils/app_utils.dart';
import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/cubits/profile_state.dart';
import 'package:event_planning/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserButtonBlocConsumer extends StatelessWidget {
  const UpdateUserButtonBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (_, state) => _listenWhen(state),
      buildWhen: (_, state) => state.status == ProfileStatus.pickImg,
      listener: (_, state) => _listener(state, context),
      builder: (_, state) {
        final pickedImg = state.pickedImg;
        return ElevatedButton(
          onPressed: pickedImg != null
              ? () {
                  context.read<ProfileCubit>().updateProfileImg();
                }
              : () {
                  context.read<ProfileCubit>().updateUser();
                },
          child:
              Text(pickedImg != null ? 'Update Profile Image' : 'Updated User'),
        );
      },
    );
  }

  bool _listenWhen(ProfileState state) {
    return state.status == ProfileStatus.updateUserLoading ||
        state.status == ProfileStatus.updateImgSuccess ||
        state.status == ProfileStatus.updateUserFailure ||
        state.status == ProfileStatus.updateImgSuccess ||
        state.status == ProfileStatus.updateImgLoading ||
        state.status == ProfileStatus.updateImgFailure;
  }

  void _listener(ProfileState state, BuildContext context) async {
    switch (state.status) {
      case ProfileStatus.updateUserLoading:
      case ProfileStatus.updateImgLoading:
        context.showLoadingDialog();
      case ProfileStatus.updateImgFailure:
      case ProfileStatus.updateUserFailure:
        context.popTop();
        context.showAppDialog(content: state.errorMessage!);
      case ProfileStatus.updateUserSuccess:
        currentUser = state.user;
        await UserModel.secureUser(state.user!);
        context.popTop();
        context.showAppDialog(content: 'User updated successfully');
      case ProfileStatus.updateImgSuccess:
        currentUser = currentUser!.copyWith(avatarUrl: state.avatarUrl);
        await UserModel.secureUser(state.user!);
        context.popTop();
        context.showAppDialog(content: 'Profile image updated successfully');
      default:
        break;
    }
  }
}
