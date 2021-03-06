import 'dart:io';

import 'package:autospotify/ui/introduction/intro_start_page.dart';
import 'package:autospotify/ui/no_network_connection_page.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:theme_provider/theme_provider.dart';

import 'home/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin<SplashScreen> {
  Future checkIntroSeen() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    bool _introSeen = (sharedPrefs.getBool('introSeen') ?? false);

    await new Future.delayed(const Duration(seconds: 5));
    
    try {
      // Check for Network Connection
      final connectionResult = await InternetAddress.lookup('google.com');
      
      // Network Connection start app normally
      if (_introSeen) {    
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomePage())
        );
      }
      else {
        await sharedPrefs.setBool('introSeen', true);
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroStartPage())
        );
      }
    } on SocketException catch (exception) {
      // No Network Connection show error page
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new NoNetworkConnectionPage())
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkIntroSeen();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
      body: Container(
        height: SizeConfig.heightMultiplier * 100,
        width: SizeConfig.widthMultiplier * 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: SizeConfig.heightMultiplier * 40,
                width: SizeConfig.widthMultiplier * 40,
                child: Image.asset(
                  'assets/logo.png'
                ),
              ),
              Padding(padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 20)),
              Text(
                'AutoSpotify',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: ThemeProvider.themeOf(context).data.primaryColor,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 5)),
              CircularProgressIndicator(
                backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
                strokeWidth: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}