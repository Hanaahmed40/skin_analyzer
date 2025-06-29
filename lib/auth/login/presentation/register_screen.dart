import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/cubits/register_cubit.dart';
import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:event_planning/widget/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/routes.dart';
import 'widgets/register_button_bloc_listener.dart';
import 'widgets/register_confirm_pass_field_bloc_selector.dart';
import 'widgets/register_pass_field_bloc_selector.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.08, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              Image.asset(
                'assets/images/Logo.png',
                width: width * 0.8,
                height: height * 0.33,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                controller: context.read<RegisterCubit>().emailController,
                hintText: AppLocalizations.of(context)!.email,
                prefix: Icon(Icons.email_sharp),
                obscureText: false,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const RegisterPassFieldBlocSelector(),
              SizedBox(
                height: height * 0.02,
              ),
              const RegisterConfirmPassFieldBlocSelector(),
              SizedBox(
                height: height * 0.02,
              ),
              const RegisterButtonBlocListener(),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () => context.pushNamed(Routes.login),
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      TextSpan(
                          text: AppLocalizations.of(context)!
                              .already_have_account,
                          style: TextStyle(
                              color: AppColors.blackColor, fontSize: 16)),
                      TextSpan(
                          text: AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          )),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
