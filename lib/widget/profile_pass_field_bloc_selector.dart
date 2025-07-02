import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/cubits/profile_state.dart';
import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePassFieldBlocSelector extends StatelessWidget {
  const ProfilePassFieldBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, bool>(
      selector: (state) => state.isPassObscure,
      builder: (context, isPasswordObscure) => CustomTextField(
       // controller: context.read<ProfileCubit>().passwordController,
        hintText: AppLocalizations.of(context)!.password,
        suffix: IconButton(
            onPressed: () {
              context.read<ProfileCubit>().togglePassVisibility();
            },
            icon: Icon(isPasswordObscure
                ? Icons.visibility_sharp
                : Icons.visibility_off_sharp)),
        prefix: Icon(Icons.lock_sharp),
        obscureText: isPasswordObscure,
      ),
    );
  }
}
