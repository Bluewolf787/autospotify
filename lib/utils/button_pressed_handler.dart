import 'package:autospotify/utils/firestore_helper.dart';
import 'package:autospotify/utils/youtube_utils.dart';
import 'package:autospotify/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

class ButtonPressedHandler {

  Future<void> syncPlaylistsButton(BuildContext context, String spotifyPlaylistId, String youtubePlaylistUrl, String userId) async {
    if (youtubePlaylistUrl.isEmpty) {
      CustomSnackbar.show(context, 'Please enter a YouTube playlist');
      return;
    }

    // TODO: Sync Playlists

  }

  void changeThemeButton(BuildContext context) {
    ThemeProvider.controllerOf(context).nextTheme();
  }

  void pushAndReplaceToPage(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageTransition(child: page, type: PageTransitionType.fade)
    );
  }

  void pushToPage(BuildContext context, Widget page, Function whenComplete) {
    Navigator.push(
      context,
      PageTransition(child: page, type: PageTransitionType.fade)
    ).whenComplete(whenComplete);
  }

  Future<bool> onBackButtonExit(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
        title: Text(
          'Exit AutoSpotify',
          style: TextStyle(color: ThemeProvider.themeOf(context).data.primaryColor),
        ),
        content: Text(
          'Are you sure to exit?',
          style: TextStyle(color: ThemeProvider.themeOf(context).data.primaryColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop(false);
              }),
            },
            child: Text(
              'No',
              style: TextStyle(color: ThemeProvider.themeOf(context).data.accentColor)
            ),
          ),
          TextButton(
            onPressed: () => {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop(true);
              }),
            },
            child: Text(
              'Yes',
              style: TextStyle(color: ThemeProvider.themeOf(context).data.accentColor),
            ),
          ),
        ],
      ),
    ) ?? false;
  }

}
