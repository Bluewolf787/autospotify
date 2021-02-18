import 'package:autospotify_design/ui/splash_screen.dart';
import 'package:autospotify_design/ui/introduction/intro_start_page.dart';
import 'package:autospotify_design/ui/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Force the application in portrait mode
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    // Hide Statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
          child: IntroStartPage(), //SplashScreen()
        ),
      ),
    );
  }
}
