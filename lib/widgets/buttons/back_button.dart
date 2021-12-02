import 'package:autospotify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        Icons.keyboard_arrow_left,
        color: ThemeProvider.themeOf(context).data.primaryColor,
        size: 24,
      ),
      label: Text(
        AppLocalizations.of(context).btnBack,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
      )
    );
  }
}