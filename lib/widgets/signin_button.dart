import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key key,
    this.onPressed,
    this.assetImage,
    this.label,
    this.color,
  }) : super(key: key);

  final Function onPressed;
  final String assetImage;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      borderSide: BorderSide(
        color: color,
      ),
      highlightColor: color,
      highlightedBorderColor: color,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(assetImage),
              height: 15,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ThemeProvider.themeOf(context).data.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}