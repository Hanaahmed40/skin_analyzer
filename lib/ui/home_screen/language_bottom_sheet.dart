import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                languageProvider.changeLanguage('en');
              },
              child: languageProvider.appLanguage == 'en '
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                  : getUnselectedItemWidget(
                      AppLocalizations.of(context)!.english)),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar '
                ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                : getUnselectedItemWidget(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        const Icon(
          Icons.check,
          color: AppColors.primaryLight,
          size: 25,
        )
      ],
    );
  }

  Widget getUnselectedItemWidget(String text) {
    return Text(
      text,
      style: TextStyle(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.bold,
          fontSize: 22),
    );
  }
}
