import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/cubits/profile_state.dart';
import 'package:event_planning/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/routes.dart';

class LogoutBlocListener extends StatelessWidget {
  const LogoutBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (_, current) =>
          current.status == ProfileStatus.logoutSuccess ||
          current.status == ProfileStatus.logoutFailure,
      listener: (context, state) async => await _listener(state, context),
      child: IconButton(
        onPressed: () => context.read<ProfileCubit>().logout(),
        icon: Icon(Icons.logout),
        color: Colors.red,
      ),
    );
  }

  Future<void> _listener(ProfileState state, BuildContext context) async {
    switch (state.status) {
      case ProfileStatus.logoutSuccess:
        await UserModel.deleteSecuredUser();
        context.pushNamedAndRemoveUntil(Routes.login);
      case ProfileStatus.logoutFailure:
        context.showAppDialog(content: state.errorMessage!);
      default:
        break;
    }
  }
}
