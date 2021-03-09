import 'package:autospotify/ui/splash_screen.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

class NoNetworkConnectionPage extends StatefulWidget {
  NoNetworkConnectionPage({Key key}) : super(key: key);

  @override
  _NoNetworkConnectionPageState createState() => _NoNetworkConnectionPageState();
}

class _NoNetworkConnectionPageState extends State<NoNetworkConnectionPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => ButtonPressedHandler().onBackButtonExit(context),
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: Container(
          height: SizeConfig.heightMultiplier * 100,
          width: SizeConfig.widthMultiplier * 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.wifi_off_rounded,
                  size: 142,
                  color: ThemeProvider.themeOf(context).data.primaryColor,
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Text(
                  'No network connection',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: ThemeProvider.themeOf(context).data.primaryColor,
                    height: 1.3,
                    letterSpacing: 1.5,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 40)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(child: SplashScreen(), type: PageTransitionType.fade)
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      return ThemeProvider.themeOf(context).data.canvasColor;
                    }),
                  ),
                  child: Text(
                    'try again'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: ThemeProvider.themeOf(context).data.accentColor,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}