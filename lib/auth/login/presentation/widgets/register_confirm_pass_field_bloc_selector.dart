import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:event_planning/cubits/register_cubit.dart';
import 'package:event_planning/cubits/register_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widget/custom_text_field.dart';

class RegisterConfirmPassFieldBlocSelector extends StatelessWidget {
  const RegisterConfirmPassFieldBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
      selector: (state) => state.isConfirmPassObscure,
      builder: (context, isConfirmPassObscure) => CustomTextField(
        controller: context.read<RegisterCubit>().confirmPassController,
        hintText: AppLocalizations.of(context)!.re_password,
        suffix: IconButton(
          onPressed: () {
            context.read<RegisterCubit>().toggleConfirmPassVisibility();
          },
          icon: Icon(
            isConfirmPassObscure
                ? Icons.visibility_sharp
                : Icons.visibility_off_sharp,
          ),
        ),
        prefix: Icon(Icons.lock_sharp),
        obscureText: isConfirmPassObscure,
      ),
    );
  }
}
