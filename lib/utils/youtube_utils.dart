import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YouTubeUtils {

  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  checkPlaylistId(String playlistUrl) async {
    String playlistId = '';
    Playlist playlist;

    // Extrac playlist id
    try {
      playlistId = playlistUrl.replaceRange(0, 'https://youtube.com/playlist?list='.length, '');
    } catch (RangeError) {
      print('RangeError: $RangeError');
    }
    // Get the playlist by the extraced id
    try {
      playlist = await _youtubeExplode.playlists.get(playlistId);
      getPlaylist(playlist);
    } catch (Invalid) {
      print('Invalid Error: $Invalid');
    }

  }

  getPlaylist(Playlist playlist) async {
    var title = playlist.title;
    var author = playlist.author;

    print('Playlist title: $title and author $author');
  }

  getVideosFromPlaylist(String playlistId) async {
    var playlistVideos = _youtubeExplode .playlists.getVideos(playlistId);

    Map<String, String> videos = Map<String, String>();

    await for (var video in playlistVideos) {
      var videoTitle = video.title;
      var videoAuthor = video.author;

      videos.putIfAbsent(videoTitle, () => videoAuthor);
    }
  }

}