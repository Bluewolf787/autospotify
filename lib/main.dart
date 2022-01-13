import 'package:autospotify/l10n/app_localizations.dart';
import 'package:autospotify/ui/splash_screen.dart';
import 'package:autospotify/ui/theme/custom_theme.dart';
import 'package:autospotify/utils/db/shared_prefs_helper.dart';
import 'package:autospotify/utils/supported_languages.dart';
import 'package:autospotify/widgets/layout/no_network_connection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final Future<FirebaseApp>? _initialization = Firebase.initializeApp();

  SharedPreferencesHelper _sharedPrefs = new SharedPreferencesHelper();

  Locale? _locale;
  void _getCurrentLocale() async {
    String _currentLanguageCode;
    _sharedPrefs.getCurrentLanguage().then((language) {
      setState(() {
        _currentLanguageCode = SupportedLanguages.LANGUAGES.keys.firstWhere(
            (key) => SupportedLanguages.LANGUAGES[key] == language,
            orElse: () => '');
        if (_currentLanguageCode != '')
          _locale = Locale(_currentLanguageCode, '');
      });
    });
  }

  Locale? getCurrentLocal() {
    return _locale;
  }

  void setLocale(String? currentLanguage) async {
    String? _languagesCode = SupportedLanguages.LANGUAGES.keys.firstWhere(
        (key) => SupportedLanguages.LANGUAGES[key] == currentLanguage,
        orElse: () => '');
    setState(() {
      _locale = Locale.fromSubtags(languageCode: _languagesCode);
    });
    await _sharedPrefs
        .setLanguage(SupportedLanguages.LANGUAGES[_languagesCode]);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocale();
  }

  @override
  Widget build(BuildContext context) {
    // Force the application in portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Hide Statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Stack(
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                NoNetworkConnection(),
              ],
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
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en', ''),
                  const Locale('de', 'DE'),
                  const Locale('fr', 'FR'),
                ],
                locale: _locale,
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
