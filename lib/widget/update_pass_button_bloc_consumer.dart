import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/cubits/profile_state.dart';
import 'package:event_planning/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePassButtonBlocConsumer extends StatelessWidget {
  const UpdatePassButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (_, state) => _listenWhen(state),
        listener: (context, state) => _listener(context, state),
        buildWhen: (previous, current) => _buildWhen(current),
        builder: (context, state) => ElevatedButton(
          onPressed: () => context.read<ProfileCubit>().updatePassword(),
          child: state.status == ProfileStatus.updatePassLoading
              ? SizedBox.square(
                  dimension: 16,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text('Update'),
        ),
      ),
    );
  }

  bool _buildWhen(ProfileState current) {
    return current.status == ProfileStatus.updatePassLoading ||
        current.status == ProfileStatus.updatePassSuccess ||
        current.status == ProfileStatus.updatePassFailure;
  }

  bool _listenWhen(ProfileState state) {
    return state.status == ProfileStatus.updatePassSuccess ||
        state.status == ProfileStatus.updatePassFailure;
  }

  void _listener(BuildContext context, ProfileState state) async {
    context.popTop();
    switch (state.status) {
      case ProfileStatus.updatePassSuccess:
        await UserModel.deleteSecuredUser();
        await UserModel.secureUser(state.user!);
        context.showToast('Password updated successfully');
      case ProfileStatus.updatePassFailure:
        context.showAppDialog(content: state.errorMessage!);
      default:
        break;
    }
  }
}
