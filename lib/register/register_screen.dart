
import 'package:event_planning/auth/login/login_screen.dart';
import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:event_planning/widget/custom_text_field.dart';
class RegisterScreen extends StatefulWidget{
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.register,
        style: TextStyle(
          fontSize: 25,
fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),),
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*0.08 ,
            vertical: height*0.02
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              Image.asset('assets/images/Logo.png',
                width: width * 0.8,
                height: height * 0.33,
                fit: BoxFit.contain,),

              CustomTextField(
                 hintText : AppLocalizations.of(context)!.name,
               prefixIcon: Icons.person,
                obscureText: false,),
                SizedBox(height: height*0.02,),
              CustomTextField(
                hintText : AppLocalizations.of(context)!.email,
                prefixIcon: Icons.email_sharp,
                obscureText: false,
              ),
              SizedBox(height: height*0.02,),
              CustomTextField(
                hintText : AppLocalizations.of(context)!.password,
                suffixIcon: Icons.visibility_off_sharp,
                prefixIcon: Icons.lock_sharp,
                obscureText: true,
                isPasswordField: true,
              ),
              SizedBox(height: height*0.02,),
              CustomTextField(
                hintText : AppLocalizations.of(context)!.re_password,
                suffixIcon: Icons.visibility_off_sharp,
                prefixIcon: Icons.lock_sharp,
                obscureText: true,
                isPasswordField: true,
              ),

              SizedBox(height: height*0.02,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight, // لون الزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // زوايا مستديرة
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15), // ارتفاع الزر
                ),
                child: Text(
                  AppLocalizations.of(context)!.create_account, // ترجمة زر تسجيل الدخول
                  style: TextStyle(fontSize: 20, color: AppColors.whiteColor),
                ),
              ),
              SizedBox(height: height*0.02,),
         InkWell(
           onTap: (){
             Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
           },
           child: Text.rich(
             textAlign: TextAlign.center,
               TextSpan(
             children: [
               TextSpan(
                 text: AppLocalizations.of(context)!.already_have_account,
                 style: TextStyle(
                   color: AppColors.blackColor,
                   fontSize: 16
                 )
               ),
               TextSpan(
                   text: AppLocalizations.of(context)!.login,
                   style: TextStyle(
                       color: AppColors.primaryLight,
                       fontSize: 18,
                     fontWeight: FontWeight.bold,
                     decoration: TextDecoration.underline,
                     decorationColor: AppColors.primaryLight,
                   )
               ),
             ]
           )),
         ),


        ],
        ),
        ),
      ),
    );
  }
}