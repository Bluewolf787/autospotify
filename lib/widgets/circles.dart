import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Circle extends StatelessWidget {
  final double diameter;
  final Color color;
  final bool notFilled;

  Circle({this.diameter, this.color, this.notFilled});

  @override
  Widget build(BuildContext context) {
    if (!notFilled) {
      return Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          color: color,
          boxShadow: [
            BoxShadow(
              color: const Color(0x40000000),
              offset: Offset(5, -3),
              blurRadius: 6,
            ),
          ],
        ),
      );
    }
    else {
      return Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          border: Border.all(
            width: 2.0,
            color: color,
          ),
        ),
      );
    }
  }
}