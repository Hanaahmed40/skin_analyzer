import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:event_planning/widget/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/routes.dart';
import 'cubits/login_cubit.dart';
import 'widgets/login_button_bloc_listener.dart';
import 'widgets/login_pass_text_field_bloc_selector.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.08, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.05),
              Image.asset(
                'assets/images/Logo.png',
                width: width * 0.8,
                height: height * 0.33,
                fit: BoxFit.contain,
              ),
              // SizedBox(height: height*0.05,),

              CustomTextField(
                controller: context.read<LoginCubit>().emailController,
                hintText: AppLocalizations.of(context)!.email,
                prefix: Icon(Icons.email_sharp),
                obscureText: false,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const LoginPassTextFieldBlocSelector(),
              SizedBox(
                height: height * 0.02,
              ),
            /* InkWell(
                onTap: () => context.pushNamed(Routes.forgotPass),
                child: Text(
                  AppLocalizations.of(context)!.forget_password,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  ),
                ),
              ),*/
              SizedBox(
                height: height * 0.02,
              ),
              const LoginButtonBlocListener(),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  context.pushNamed(Routes.register);
                },
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      TextSpan(
                          text: AppLocalizations.of(context)!.dontHaveAccount,
                          style: TextStyle(
                              color: AppColors.blackColor, fontSize: 16)),
                      TextSpan(
                          text: AppLocalizations.of(context)!.create_account,
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          )),
                    ])),
              ),
              SizedBox(
                height: height * 0.02,
              ),
             /* Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.primaryLight,
                      endIndent: 20,
                      indent: 10,
                    ),
                  ),
                 Text(
                    AppLocalizations.of(context)!.or,
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.primaryLight,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),*/
            /*  GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryLight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/super g.png',
                          width: 24), // تأكد من إضافة الصورة في مجلد assets
                      SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.login_with_google,
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
