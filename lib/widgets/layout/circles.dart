import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Circle extends StatelessWidget {
  Circle({
    Key key,
    this.diameter, 
    this.color,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.notFilled,
  }) : super(key: key);
  
  final double diameter;
  final Color color;
  final Offset shadowOffset;
  final double shadowBlurRadius;
  final bool notFilled;

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
              offset: shadowOffset,
              blurRadius: shadowBlurRadius,
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