import 'package:autospotify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CloseDialog extends StatelessWidget {
  CloseDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
      title: Text(
        AppLocalizations.of(context).exitHeader,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          height: 1.3,
        ),
      ),
      content: Text(
        AppLocalizations.of(context).exitContent,
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
            AppLocalizations.of(context).btnNo.toUpperCase(),
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
            AppLocalizations.of(context).btnYes.toUpperCase(),
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