import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class Utils {

  static Future<bool> onBackButtonExit(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
        title: Text(
          'Exit AutoSpotify',
          style: TextStyle(color: ThemeProvider.themeOf(context).data.primaryColor),
        ),
        content: Text(
          'Are you sure to exit?',
          style: TextStyle(color: ThemeProvider.themeOf(context).data.primaryColor),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop(false);
              }),
            },
            child: Text(
              'No',
              style: TextStyle(color: ThemeProvider.themeOf(context).data.accentColor)
            ),
          ),
          FlatButton(
            onPressed: () => {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop(true);
              }),
            },
            child: Text(
              'Yes',
              style: TextStyle(color: ThemeProvider.themeOf(context).data.accentColor),
            ),
          ),
        ],
      ),
    ) ?? false;
  }
  
}