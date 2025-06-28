

import 'package:event_planning/register/register_screen.dart';

import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetScreen extends StatelessWidget{
  static const String routeName = 'forget_screen';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.forge_password,
        style: TextStyle(

          fontSize: 25,

          color: AppColors.blackColor,
          fontWeight: FontWeight.bold
        ),),
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*0.04 ,
            vertical: height*0.07
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/forget_image.png',
              fit: BoxFit.cover,),
              SizedBox(height: height*0.03),
              CustomTextField(
                hintText : AppLocalizations.of(context)!.email,
                prefixIcon: Icons.email_sharp,
                obscureText: false,
              ),
              SizedBox(height: height*0.01),
        
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight, // لون الزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // زوايا مستديرة
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15), // ارتفاع الزر
                ),
                child: Text(
                  AppLocalizations.of(context)!.reset_password,// ترجمة زر تسجيل الدخول
                  style: TextStyle(fontSize: 20, color: AppColors.whiteColor),
                ),
              ),
              SizedBox(height: height*0.02,),
        
        
        
        
        ],
        ),
        ),
      ),
    );
  }

}