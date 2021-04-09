import 'package:autospotify/utils/auth/fire_auth.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:autospotify/widgets/input/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key key,
    @required this.text
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
      title: Text(
        'Oops! Something unexpected happend',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,
        ),
      ),
      content: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            Navigator.of(context).pop(),
          },
          child: Text(
            'OK',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.4,
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
        TextButton(
          onPressed: () => {
            Navigator.of(context).pop(),
          },
          child: Text(
            'OK',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.4,
              color: ThemeProvider.themeOf(context).data.accentColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            await user.sendEmailVerification();
            Navigator.of(context).pop();
          },
          child: Text(
            'SEND AGAIN',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.4,
              color: ThemeProvider.themeOf(context).data.accentColor,
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({
    Key key,
    @required this.controller
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SimpleDialog(
      backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
      title: Text(
        'Reset Password',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,
        ),
      ),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'Please enter your E-Mail address',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ThemeProvider.themeOf(context).data.primaryColor,
                height: 1.3,
              ),
            ),

            Padding(padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2)),

            Container(
              width: SizeConfig.widthMultiplier * 70,
              padding: EdgeInsets.zero,
              child: CustomTextField(
                controller: controller,
                emailField: true,
                passwordField: false,
                readOnly: false,
                hintText: 'Enter your E-Mail',
                labelText: 'E-Mail',
                suffixIcon: Icon(
                  Icons.mail_rounded,
                  color: ThemeProvider.themeOf(context).data.primaryColor,
                  size: 20,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    await FireAuth().sendPasswordResetEmail(controller.text).then((success) {
                      if (success) {
                        CustomSnackbar.show(context, 'We sent you a E-Mail to reset your password');
                      }
                      else {
                        CustomSnackbar.show(context, 'Oops! Something went wrong. Please try again');
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Submit'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.4,
                      color: ThemeProvider.themeOf(context).data.accentColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.4,
                      color: ThemeProvider.themeOf(context).data.accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class CloseDialog extends StatelessWidget {
  CloseDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
      title: Text(
        'Exit AutoSpotify',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,
        ),
      ),
      content: Text(
        'Are you sure to exit?',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,  
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).pop(false);
            }),
          },
          child: Text(
            'no'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.4,
              color: ThemeProvider.themeOf(context).data.accentColor
            ),
          ),
        ),
        TextButton(
          onPressed: () => {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop(true);
            }),
          },
          child: Text(
            'yes'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 1.4,
              color: ThemeProvider.themeOf(context).data.accentColor
            ),
          ),
        ),
      ],
    ) ?? false;
  }
}