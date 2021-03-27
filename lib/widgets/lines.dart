import 'package:flutter/material.dart';

class Lines extends StatelessWidget {
  Lines({
    Key key,
    @required this.positionTop
  }) : super(key: key);

  final bool positionTop;

  @override
  Widget build(BuildContext context) {
    if (positionTop) {
      return SizedBox(
        width: 236.0,
        height: 0.0,
        child: Stack(
          children: <Widget>[
            // Green line
            Align(
              alignment: Alignment(92.0, 1.0),
              child: Divider(
                height: 0.0,
                indent: 152.5,
                endIndent: 9.5,
                color: const Color(0xff1db954),
                thickness: 4,
              ),
            ),
            // Blue line
            Align(
              alignment: Alignment(164.0, 1.0),
              child: Divider(
                height: 0.0,
                indent: 22.5,
                endIndent: 80.5,
                color: Colors.blue,
                thickness: 4,
              ),
            ),
          ],
        ),
      );
    }
    else {
      return SizedBox(
        width: 256.0,
        height: 0.0,
        child: Stack(
          children: <Widget>[
            // Green line
            Align(
              alignment: Alignment(92.0, 1.0),
              child: Divider(
                height: 0.0,
                indent: 12.5,
                endIndent: 164.5,
                color: const Color(0xff1db954),
                thickness: 4,
              ),
            ),
            // Blue line
            Align(
              alignment: Alignment(164.0, 1.0),
              child: Divider(
                height: 0.0,
                indent: 82.5,
                endIndent: 20.5,
                color: Colors.blue,
                thickness: 4,
              ),
            ),
          ],
        ),
      );
    }
  }
}