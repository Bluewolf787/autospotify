import 'package:autospotify_design/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.onBackButtonExit(context),
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: Center(
          child: Text(
            'This is the home screen',
            style: TextStyle(color: ThemeProvider.themeOf(context).data.primaryColor),
          ),
        ),
      ),
    );
  }
}