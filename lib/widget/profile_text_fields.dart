import 'package:event_planning/cubits/profile_cubit.dart';
import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/widget/custom_text_field.dart';
//import 'package:event_planning/widget/profile_pass_field_bloc_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTextFields extends StatelessWidget {
  const ProfileTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextField(
          controller: context.read<ProfileCubit>().nameController,
          hintText: AppLocalizations.of(context)!.name,
          prefix: Icon(Icons.person),
          obscureText: false,
        ),
        CustomTextField(
          controller: context.read<ProfileCubit>().emailController,
          hintText: AppLocalizations.of(context)!.email,
          prefix: Icon(Icons.email_sharp),
          obscureText: false,
        ),
      ],
    );
  }
}
