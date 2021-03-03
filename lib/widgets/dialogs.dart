import 'package:firebase_auth/firebase_auth.dart';
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

class VerifyEmailDialog extends StatelessWidget {
  const VerifyEmailDialog({
    Key key,
    this.user,
    this.email,
  }) : super(key: key);

  final User user;
  final String email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
      title: Text(
        'E-Mail Verification',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,
        ),
      ),
      content: Text(
        'Please verify your E-Mail address with the link we sent you to $email.\nMay check also your spam folder.\nIf you have already verified your E-Mail address try to sign new in.',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,
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
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              color: ThemeProvider.themeOf(context).data.accentColor,
            ),
          ),
        ),
        FlatButton(
          onPressed: () async {
            await user.sendEmailVerification();
            Navigator.of(context).pop();
          },
          child: Text(
            'SEND AGAIN',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              color: ThemeProvider.themeOf(context).data.accentColor,
            ),
          ),
        ),
      ],
    );
  }
}