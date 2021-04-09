import 'package:autospotify/ui/splash_screen.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class NoNetworkConnection extends StatelessWidget {
  const NoNetworkConnection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Visibility(
      visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
      child: Container(
        height: SizeConfig.heightMultiplier * 100,
        width: SizeConfig.widthMultiplier * 100,
        color: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
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
                'no network connection'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: ThemeProvider.themeOf(context).data.primaryColor,
                  height: 1.3,
                  letterSpacing: 1.3,
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
    );
  }
}