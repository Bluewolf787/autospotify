import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomTheme {
  AppTheme darkTheme() {
    return AppTheme(
      id: 'dark_theme',
      description: 'Custom dark color theme',
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        accentColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.black,
        unselectedWidgetColor: Colors.grey,
        toggleableActiveColor: Colors.yellow,
      ),
    );
  }

  AppTheme lightTheme() {
    return AppTheme(
      id: 'light_theme',
      description: 'Custom light color theme',
      data: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        unselectedWidgetColor: Colors.grey,
        toggleableActiveColor: Colors.blue,
      ),
    );
  }
}