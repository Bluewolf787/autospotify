import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key key,
    @required this.onPressed,
    @required this.assetImage,
    @required this.label,
    this.color,
  }) : super(key: key);

  final Function onPressed;
  final String assetImage;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return color;
        }),
        shape: MaterialStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          );
        }),
        side: MaterialStateProperty.resolveWith((states) {
          return BorderSide(
            color: color,
          );
        }),
      ),
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