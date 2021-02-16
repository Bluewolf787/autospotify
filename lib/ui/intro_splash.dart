import 'package:autospotify_design/ui/intro_start_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import 'home_page.dart';

class IntroSplash extends StatefulWidget {
  @override
  _IntroSplashState createState() => new _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash> with AfterLayoutMixin<IntroSplash> {
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
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}