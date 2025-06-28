import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap:(){
           themeProvider.changeTheme(ThemeMode.dark);

            },
              child: themeProvider.isDarkMod()?
              getSelectedItemWidget(AppLocalizations.of(context)!.dark):
              getUnselectedItemWidget(AppLocalizations.of(context)!.dark)
          ),
          SizedBox(height: height *0.02,),
          InkWell(
            onTap: (){
              themeProvider.changeTheme(ThemeMode.light);

            },
            child: themeProvider.isDarkMod()?
getUnselectedItemWidget(AppLocalizations.of(context)!.light):
  getSelectedItemWidget(AppLocalizations.of(context)!.light),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
          style: TextStyle(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.bold,
              fontSize: 22
          ),),
       const Icon(Icons.check, color: AppColors.primaryLight,
          size: 25,)
      ],
    );
  }

    Widget getUnselectedItemWidget( String text){
return Text(text,
  style: TextStyle(
      color: AppColors.primaryDark,
      fontWeight: FontWeight.bold,
      fontSize: 22
  ),);
    }
}

