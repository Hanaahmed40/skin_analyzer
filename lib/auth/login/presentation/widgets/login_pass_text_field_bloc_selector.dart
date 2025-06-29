import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../widget/custom_text_field.dart';
import '../cubits/login_cubit.dart';
import '../cubits/login_state.dart';

class LoginPassTextFieldBlocSelector extends StatelessWidget {
  const LoginPassTextFieldBlocSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) => state.isPasswordObscure,
      builder: (context, isPasswordObscure) => CustomTextField(
        controller: context.read<LoginCubit>().passwordController,
        hintText: AppLocalizations.of(context)!.password,
        suffix: IconButton(
            onPressed: () {
              context.read<LoginCubit>().togglePasswordVisibility();
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
