import 'package:autospotify/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YouTubeUtils {

  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  // Get the ID from a YouTube playlist
  Future<String> getPlaylistId(BuildContext context, String playlistUrl) async {
    // Extrac playlist id
    try {
      final String playlistId = playlistUrl.replaceRange(0, 'https://youtube.com/playlist?list='.length, '');
      
      final valid = _checkPlaylistId(context, playlistId);
      if (valid != null)
        return null;

      return playlistId;
    } catch (RangeError) {
      print('RangeError: $RangeError');
      CustomSnackbar.show(context, 'Oops! Something went wrong getting the playlist ID please check the provided link');

      return null;
    }
  }

  // Check if a YouTube playlist ID is actual valid
  Future<Playlist> _checkPlaylistId(BuildContext context, String playlistId) async {
    // Get the playlist by ID
    try {
      final playlist = await _youtubeExplode.playlists.get(playlistId);
      
      return playlist;
    } catch (Invalid) {
      print('Invalid Error: $Invalid');
      CustomSnackbar.show(context, 'The provided playlist ID is not valid');
      
      return null;
    }
  }

  // Get infos of a YouTube playlist
  getPlaylistInfos(Playlist playlist) async {
    var title = playlist.title;
    var author = playlist.author;

    print('Playlist title: $title and author $author');
  }

  // Get all videos from a YouTube playlist
  Future<List<String>> getVideosFromPlaylist(BuildContext context, String playlistUrl) async {
    try {
      final playlistVideos = _youtubeExplode.playlists.getVideos(playlistUrl);

      List<String> videos = [];


      await for (var video in playlistVideos) {
        var videoTitle = video.title;

        videos.add(videoTitle);
      }
      
      print(videos);
      return videos;
    } catch (exception) {
      print('YT-Utils: $exception');
      CustomSnackbar.show(context, 'The provided playlist URL is not valied');
      
      return null;
    }
  }

}