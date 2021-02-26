import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
      title: Text(
        'Oops! Something unexpected happend',
        style: TextStyle(
          color: ThemeProvider.themeOf(context).data.primaryColor,
        ),
      ),
      content: Text(
        text,
        style: TextStyle(
          color: ThemeProvider.themeOf(context).data.primaryColor,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => {
            Navigator.of(context).pop(),
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: ThemeProvider.themeOf(context).data.accentColor,
            ),
          ),
        ),
      ],
    );
  }
}