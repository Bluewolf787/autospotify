import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomSnackbar {
  const CustomSnackbar({
    @required this.text,
    this.action,
  });

  final String text;
  final SnackBarAction action;

  static show(BuildContext context, String text, [SnackBarAction action]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
        content: Text(
          text,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            color: ThemeProvider.themeOf(context).data.primaryColor
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: action,
      ),
    );
  }
}