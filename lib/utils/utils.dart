import 'package:flutter/material.dart';

class Utils {

  static Future<bool> onBackButtonExit(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit AutoSpotify'),
        content: Text('Are you sure to exit?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop(false);
              }),
            },
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop(true);
              }),
            },
            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }
  
}