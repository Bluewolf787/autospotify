import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/sync_status.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.widthMultiplier! * 100,
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.fromLTRB(45, 10, 45, 10);
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0));
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return ThemeProvider.themeOf(context).data.accentColor;
          }),
        ),
        onPressed: onPressed,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig.textMultiplier! * 3.6,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

class SyncButton extends StatelessWidget {
  SyncButton({
    Key? key,
    required this.onPressed,
    required this.syncStatus,
  }) : super(key: key);

  final VoidCallback onPressed;
  final SyncStatus syncStatus;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.widthMultiplier! * 100,
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.fromLTRB(45, 10, 45, 10);
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0));
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return ThemeProvider.themeOf(context).data.accentColor;
          }),
        ),
        onPressed: onPressed,
        child: _SyncButtonChild(
          syncStatus: syncStatus,
        ),
      ),
    );
  }
}

class _SyncButtonChild extends StatelessWidget {
  _SyncButtonChild({
    Key? key,
    required this.syncStatus,
  }) : super(key: key);

  final SyncStatus syncStatus;

  @override
  Widget build(BuildContext context) {
    if (syncStatus == SyncStatus.noSync) {
      return Text(
        'sync'.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 26.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          letterSpacing: 2,
        ),
      );
    } else if (syncStatus == SyncStatus.syncing) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 2,
      );
    } else if (syncStatus == SyncStatus.done) {
      return Icon(
        Icons.done_rounded,
        color: Colors.white,
        size: 28,
      );
    } else {
      return Icon(
        Icons.error_outline_rounded,
        color: Colors.white,
        size: 28,
      );
    }
  }
}
