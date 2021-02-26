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
    return FlatButton.icon(
      onPressed: onPressed,
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.keyboard_arrow_left,
        color: ThemeProvider.themeOf(context).data.primaryColor,
        size: 24,
      ),
      label: Text(
        'Back',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}