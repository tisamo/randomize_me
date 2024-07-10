import 'package:flutter/material.dart';
import 'package:randomize_me/shared/Texts/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeDataStyle = lightTheme;
  ThemeData get themeDataStyle => _themeDataStyle;

  set themeDataStyle (ThemeData themeData) {
    _themeDataStyle = themeData;
    notifyListeners();
  }
  void changeTheme() {
    if (_themeDataStyle == lightTheme) {
      themeDataStyle = darkTheme;
    } else {
      themeDataStyle = lightTheme;
    }
  }

}