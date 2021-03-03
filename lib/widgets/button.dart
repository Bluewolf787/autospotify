import 'package:autospotify/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  CustomButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.widthMultiplier * 100,
      alignment: Alignment.center,
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(45, 10, 45 , 10),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: ThemeProvider.themeOf(context).data.accentColor,
        textColor: Colors.white,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 26.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}