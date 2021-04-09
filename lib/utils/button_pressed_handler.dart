import 'dart:io';

import 'package:autospotify/ui/no_network_connection_page.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/youtube/songtitle_extractor.dart';
import 'package:autospotify/utils/spotify/spotify_utils.dart';
import 'package:autospotify/utils/youtube/youtube_utils.dart';
import 'package:autospotify/widgets/dialogs/dialogs.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify/spotify.dart';
import 'package:theme_provider/theme_provider.dart';

class ButtonPressedHandler {

  Future<void> syncPlaylistsButton(BuildContext context, SpotifyApi spotifyApi, String spotifyPlaylistId, String youtubePlaylistUrl, String userId) async {
    if (youtubePlaylistUrl.isEmpty) {
      CustomSnackbar.show(context, 'Please enter a YouTube playlist');
      return;
    }

    try {
      // Check for Network Connection
      await InternetAddress.lookup('google.com');
    } on SocketException catch (exception) {
      print(exception);
      // No Network Connection show error page
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new NoNetworkConnectionPage())
      );
      return;
    }
        
    // Get YouTube Video titles
    List<String> videosRaw = await YouTubeUtils().getVideosFromPlaylist(context, youtubePlaylistUrl);
    FirestoreHelper().saveYouTubePlaylistUrl(youtubePlaylistUrl, userId);

    // Get song titles from YouTube video titles
    List<String> songTitles = SongTitleExtractor().extract(videosRaw);
    //print('SONG TITLES: $songTitles');

    // Search for songs on Spotify
    var spotifyTracks = await SpotifyUtils().searchSongs(spotifyApi, songTitles);
    //print('Spotify tracks ::: $spotifyTracks');
    if (spotifyTracks.isEmpty) {
      CustomSnackbar.show(context, 'Could not find any songs in that YouTube playlist');
    }

    // Add songs to Spotify playlist
    await SpotifyUtils().addSongsToPlaylist(context, spotifyApi, spotifyTracks, spotifyPlaylistId, userId);

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
      builder: (context) => CloseDialog(),
    );
  }

}
