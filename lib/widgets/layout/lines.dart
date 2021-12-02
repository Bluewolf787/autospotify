import 'package:autospotify/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class Lines extends StatelessWidget {
  Lines({
    Key key,
    @required this.positionTop
  }) : super(key: key);

  final bool positionTop;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (positionTop) {
      return SizedBox(
        width: SizeConfig.widthMultiplier * 55,
        height: SizeConfig.heightMultiplier * .6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Blue line
            Container(
              width: SizeConfig.widthMultiplier * 35,
              height: SizeConfig.heightMultiplier * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                ),
                color: ThemeProvider.themeOf(context).data.accentColor,
              ),
            ),
            // Green line
            Container(
              width: SizeConfig.widthMultiplier * 20,
              height: SizeConfig.heightMultiplier * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                color: const Color(0xff1db954),
              ),
            )
          ],
        ),
      );
    }
    else {
      return SizedBox(
        width: SizeConfig.widthMultiplier * 55,
        height: SizeConfig.heightMultiplier * .6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Green line
            Container(
              width: SizeConfig.widthMultiplier * 20,
              height: SizeConfig.heightMultiplier * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                ),
                color: const Color(0xff1db954),
              ),
            ),
            // Blue line
            Container(
              width: SizeConfig.widthMultiplier * 35,
              height: SizeConfig.heightMultiplier * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                color: ThemeProvider.themeOf(context).data.accentColor,
              ),
            ),
          ],
        ),
      );
      // return SizedBox(
      //   width: 256.0,
      //   height: 0.0,
      //   child: Stack(
      //     children: <Widget>[
      //       // Green line
      //       Align(
      //         alignment: Alignment(92.0, 1.0),
      //         child: Divider(
      //           height: 0.0,
      //           indent: 12.5,
      //           endIndent: 164.5,
      //           color: const Color(0xff1db954),
      //           thickness: 4,
      //         ),
      //       ),
      //       // Blue line
      //       Align(
      //         alignment: Alignment(164.0, 1.0),
      //         child: Divider(
      //           height: 0.0,
      //           indent: 82.5,
      //           endIndent: 20.5,
      //           color: Colors.blue,
      //           thickness: 4,
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    }
  }
}