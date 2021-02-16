import 'package:autospotify_design/ui/intro_splash.dart';
import 'package:autospotify_design/ui/theme/custom_theme.dart';
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
        CustomTheme().darkTheme(),
        CustomTheme().lightTheme(),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: ThemeConsumer(
          child: IntroSplash(),
        ),
      ),
    );
  }
}
