import 'package:event_planning/core/utils/functions/check_if_onboarding_is_visited.dart';
import 'package:event_planning/core/utils/functions/check_if_user_is_logged_in.dart';
import 'package:event_planning/di.dart';
import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc_observer.dart';
import 'core/router/app_router.dart';
import 'cubits/main_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setupDI();

 await Supabase.initialize(
    url: 'https://phjjlgxkwckekztrgubf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBoampsZ3hrd2NrZWt6dHJndWJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExODY3NjIsImV4cCI6MjA2Njc2Mjc2Mn0.qfIBsaTEAOsK0J7I5BI7W_kvjTRzBgDvY6qfiz1wJ8g',
  );

  await checkIfOnboardingIsVisited();
  await checkIfIsUserLoggedIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // flutter project

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return BlocProvider<MainCubit>(
      create: (_) => getIt<MainCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.appTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(languageProvider.appLanguage),
      ),
    );
  }
}