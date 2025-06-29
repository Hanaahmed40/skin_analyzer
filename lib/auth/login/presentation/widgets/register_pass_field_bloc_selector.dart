import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/register_cubit.dart';
import '../../../../cubits/register_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widget/custom_text_field.dart';

class RegisterPassFieldBlocSelector extends StatelessWidget {
  const RegisterPassFieldBlocSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
      selector: (state) => state.isPasswordObscure,
      builder: (context, isPasswordObscure) => CustomTextField(
        controller: context.read<RegisterCubit>().passwordController,
        hintText: AppLocalizations.of(context)!.password,
        suffix: IconButton(
            onPressed: () {
              context.read<RegisterCubit>().togglePassVisibility();
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
