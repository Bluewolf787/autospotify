import 'package:autospotify/ui/splash_screen.dart';
import 'package:autospotify/ui/theme/custom_theme.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // Force the application in portrait mode
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    // Hide Statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Oops! Something went wrong.',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<DataConnectionStatus>(
            create: (_) {
              return DataConnectionChecker().onStatusChange;
            },
            initialData: DataConnectionStatus.connected,
            child: ThemeProvider(
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
                  child: SplashScreen(),
                ),
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      },
    );
  }
}
