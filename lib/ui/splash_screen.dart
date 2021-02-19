import 'package:autospotify_design/ui/introduction/intro_start_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import 'home/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin<SplashScreen> {
  Future checkIntroSeen() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    bool _introSeen = (sharedPrefs.getBool('introSeen') ?? false);

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
  }

  @override
  void afterFirstLayout(BuildContext context) => checkIntroSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}