import 'package:autospotify/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class Lines extends StatelessWidget {
  Lines({Key? key, required this.positionTop}) : super(key: key);

  final bool positionTop;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (positionTop) {
      return SizedBox(
        width: SizeConfig.widthMultiplier! * 55,
        height: SizeConfig.heightMultiplier! * .6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Blue line
            Container(
              width: SizeConfig.widthMultiplier! * 35,
              height: SizeConfig.heightMultiplier! * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: ThemeProvider.themeOf(context).data.accentColor,
              ),
            ),
            // Green line
            Container(
              width: SizeConfig.widthMultiplier! * 20,
              height: SizeConfig.heightMultiplier! * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: const Color(0xff1db954),
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        width: SizeConfig.widthMultiplier! * 55,
        height: SizeConfig.heightMultiplier! * .6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Green line
            Container(
              width: SizeConfig.widthMultiplier! * 20,
              height: SizeConfig.heightMultiplier! * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: const Color(0xff1db954),
              ),
            ),
            // Blue line
            Container(
              width: SizeConfig.widthMultiplier! * 35,
              height: SizeConfig.heightMultiplier! * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: ThemeProvider.themeOf(context).data.accentColor,
              ),
            ),
          ],
        ),
      );
    }
  }
}
