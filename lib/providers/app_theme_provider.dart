import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode _appTheme = ThemeMode.light;

  ThemeMode get appTheme => _appTheme;

  void changeTheme(ThemeMode newTheme) {
    if (_appTheme != newTheme) {
      _appTheme = newTheme;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _appTheme = _appTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool isDarkMod() => _appTheme == ThemeMode.dark;
}