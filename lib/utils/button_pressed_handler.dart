import 'package:autospotify/l10n/app_localizations.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/youtube/songtitle_extractor.dart';
import 'package:autospotify/utils/spotify/spotify_utils.dart';
import 'package:autospotify/utils/youtube/youtube_utils.dart';
import 'package:autospotify/widgets/dialogs/close_dialog.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify/spotify.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ButtonPressedHandler {

  Future<bool> syncPlaylistsButton(BuildContext context, SpotifyApi spotifyApi, String spotifyPlaylistId, String youtubePlaylistUrl, String userId) async {
    bool _status;
    
    if (youtubePlaylistUrl.isEmpty) {
      CustomSnackbar.show(context, AppLocalizations.of(context).noYtPlaylistWarning);
      return false;
    }
        
    // Get YouTube Video titles
    List<Video> videosRaw = await YouTubeUtils().getVideosFromPlaylist(context, youtubePlaylistUrl);
    if (videosRaw == null)
  
    FirestoreHelper().saveYouTubePlaylistUrl(youtubePlaylistUrl, userId);

    // Get song titles from YouTube video titles
    Map<String, List<String>> songTitles = SongTitleExtractor().extract(videosRaw);
    //print('SONG TITLES: $songTitles');

    // Search for songs on Spotify
    var spotifyTracks = await SpotifyUtils().searchSongs(spotifyApi, songTitles);
    //print('Spotify tracks ::: $spotifyTracks');
    if (spotifyTracks.isEmpty) {
      CustomSnackbar.show(context, AppLocalizations.of(context).noSongsFoundError);
      return false;
    }

    // Add songs to Spotify playlist
    await SpotifyUtils().addSongsToPlaylist(context, spotifyApi, spotifyTracks, spotifyPlaylistId, userId).then((status) {
       status ? _status = true : _status = false;
    });

    return _status;
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
