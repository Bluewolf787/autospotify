import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final Function onPressed;

  BackButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: onPressed,
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(3, 1, 3 , 1),
      icon: Icon(
        Icons.keyboard_arrow_left,
        color: Theme.of(context).canvasColor,
        size: 24,
      ),
      label: Text(
        'Back',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: Theme.of(context).canvasColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}