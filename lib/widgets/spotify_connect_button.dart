import 'package:autospotify/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ConnectSpotifyButton extends StatelessWidget {
  const ConnectSpotifyButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.heightMultiplier * 8,
      width: SizeConfig.widthMultiplier * 80,
      child: OutlineButton(
        child: Text(
          'Connect Spotify',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ThemeProvider.themeOf(context).data.primaryColor,
          ),
        ),
        highlightColor: const Color(0xff1db954),
        highlightedBorderColor: const Color(0xff1db954),
        borderSide: BorderSide(
          color: const Color(0xff1db954),
          width: 2.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}