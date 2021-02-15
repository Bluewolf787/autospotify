import 'package:autospotify_design/ui/start_page.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: <AppTheme>[
        AppTheme.light(id: 'light_theme'),
        AppTheme.dark(id: 'dark_theme'),
      ],
      child: MaterialApp(
        home: ThemeConsumer(
          child: StartPage(),
        ),
      ),
    );
  }
}
