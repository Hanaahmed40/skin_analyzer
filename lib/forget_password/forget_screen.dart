import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/l10n/app_localizations.dart';

import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../core/router/routes.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.forge_password,
          style: TextStyle(
              fontSize: 25,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/forget_image.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: height * 0.03),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.email,
                prefix: Icon(Icons.email_sharp),
                obscureText: false,
              ),
              SizedBox(height: height * 0.01),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.register);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight, // لون الزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // زوايا مستديرة
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15), // ارتفاع الزر
                ),
                child: Text(
                  AppLocalizations.of(context)!
                      .reset_password, // ترجمة زر تسجيل الدخول
                  style: TextStyle(fontSize: 20, color: AppColors.whiteColor),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
