import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function onPressed;

  CustomBackButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: onPressed,
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(3, 1, 3 , 1),
      icon: Icon(
        Icons.keyboard_arrow_left,
        color: Colors.grey,
        size: 24,
      ),
      label: Text(
        'Back',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}