import 'package:autospotify/l10n/app_localizations.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YouTubeUtils {
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  ///
  /// Get the ID from a YouTube playlist
  /// Returns ID of YouTube playlist as String
  ///
  Future<String?> getPlaylistId(
      BuildContext context, String? playlistUrl) async {
    // Extrac playlist id
    try {
      final String? playlistId = playlistUrl!
          .replaceRange(0, 'https://youtube.com/playlist?list='.length, '');

      // Check for a valid ID
      final valid = _checkPlaylistId(context, playlistId);
      if (valid == null) return null;

      // Return the playlist ID
      return playlistId;
    } catch (rangeError) {
      print('RangeError: $rangeError');
      CustomSnackbar.show(
        context,
        AppLocalizations.of(context)!.gettingYtPlaylistError,
      );

      return null;
    }
  }

  ///
  /// Check if a YouTube playlist ID is actual valid
  /// Returns YouTube playlist
  ///
  Future<Playlist?> _checkPlaylistId(
      BuildContext context, String? playlistId) async {
    // Get the playlist by ID
    try {
      // Get YouTube playlist
      final playlist = await _youtubeExplode.playlists.get(playlistId);

      // Return the playlist
      return playlist;
    } catch (invalid) {
      print('Invalid Error: $invalid');
      CustomSnackbar.show(context, AppLocalizations.of(context)!.ytUrlInvalid);

      return null;
    }
  }

  ///
  /// Get infos of a YouTube playlist
  ///
  Future<void> getPlaylistInfos(Playlist playlist) async {
    var title = playlist.title;
    var author = playlist.author;

    print('Playlist title: $title and author $author');
  }

  ///
  /// Get all videos from a YouTube playlist
  /// Returns a list with all video titles
  ///
  Future<List<Video>?> getVideosFromPlaylist(
      BuildContext context, String playlistUrl) async {
    try {
      // Get videos from playlist
      final playlistVideos = await _youtubeExplode.playlists
          .getVideos(PlaylistId(playlistUrl))
          .toList();

      print('::: VIDEOS FOUND IN PLAYLIST = ${playlistVideos.length}');

      // Return the video titles as List<String>
      return playlistVideos;
    } catch (exception) {
      print('YT-Utils: $exception');
      CustomSnackbar.show(context, AppLocalizations.of(context)!.ytUrlInvalid);

      return null;
    }
  }
}
