import 'package:autospotify/l10n/app_localizations.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ConnectSpotifyButton extends StatelessWidget {
  const ConnectSpotifyButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.heightMultiplier! * 8,
      width: SizeConfig.widthMultiplier! * 80,
      child: OutlinedButton(
        child: Text(
          AppLocalizations.of(context)!.btnConnectSpotify,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ThemeProvider.themeOf(context).data.primaryColor,
          ),
        ),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return const Color(0xff1db954);
          }),
          side: MaterialStateProperty.resolveWith((states) {
            return BorderSide(
              color: const Color(0xff1db954),
              width: 2.0,
            );
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            );
          }),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
