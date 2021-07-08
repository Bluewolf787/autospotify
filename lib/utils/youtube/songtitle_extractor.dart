import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SongTitleExtractor {

  List<String> _getSongAndArtistFromTitle(String videoTitle) {
    String artist;
    String song;

    if (videoTitle.contains(' - ')) {
      artist = videoTitle.split(' - ').first.trim();
      song = videoTitle.split(' - ')[1].trim();

    }
    else if (videoTitle.contains(' – ')) {
      artist = videoTitle.split(' – ').first.trim();
      song = videoTitle.split(' – ')[1].trim();
    }
    else if (videoTitle.contains(' — ')) {
      artist = videoTitle.split(' — ').first.trim();
      song = videoTitle.split(' — ')[1].trim();
    }
    else if (videoTitle.contains(' ~ ')) {
      artist = videoTitle.split(' ~ ').first.trim();
      song = videoTitle.split(' ~ ')[1].trim();
    }

    return [artist, song];
  }

  String _removeEverythingUnnecessaryFromSong(String songTitle) {
    if (songTitle.contains('(') && songTitle.contains(')')) {
      songTitle = songTitle.split('(').first;
    }
    
    if (songTitle.contains('[') && songTitle.contains(']')) {
      songTitle = songTitle.split('[').first;
    }

    if (songTitle.contains(' feat. ')) {
      songTitle = songTitle.split(' feat. ').first;
    }

    if (songTitle.contains(' feat ')) {
      songTitle = songTitle.split(' feat ').first;
    }
    
    if (songTitle.contains(' ft. ')) {
      songTitle = songTitle.split(' ft. ').first;
    }

    if (songTitle.contains(' ft ')) {
      songTitle = songTitle.split(' ft ').first;
    }

    if (songTitle.contains(' featuring ')) {
      songTitle = songTitle.split(' featuring ').first;
    }
    
    if (songTitle.contains(' | ')) {
      songTitle = songTitle.split(' | ').first;
    }

    if (songTitle.contains('official ')) {
      songTitle = songTitle.split('official ').first;
    }

    if (songTitle.contains('prod. by')) {
      songTitle = songTitle.split('prod. by').first;
    }

    if (songTitle.contains('\"')) {
      songTitle = songTitle.split('\"')[1];
    }

    return songTitle.trim();
  }

  String _removeEverythingUnnecessaryFromArtist(String songArtist) {
    if (songArtist.contains(' feat. ')) {
      songArtist = songArtist.split(' feat. ').first;
    }

    if (songArtist.contains(' feat ')) {
      songArtist = songArtist.split(' feat ').first;
    }

    if (songArtist.contains(' featuring ')) {
      songArtist = songArtist.split(' featuring ').first;
    }

    if (songArtist.contains(' ft. ')) {
      songArtist = songArtist.split(' ft. ').first;
    }

    if (songArtist.contains(' ft ')) {
      songArtist = songArtist.split(' ft ').first;
    }

    if (songArtist.contains('official')) {
      songArtist = songArtist.split('official').first;
    }

    if (songArtist.contains(' vs. ')) {
      songArtist = songArtist.split(' vs. ').first;
    }

    if (songArtist.contains(' - ')) {
      songArtist = songArtist.split(' - ').first;
    }

    if (songArtist.contains(' x ')) {
      songArtist = songArtist.split(' x ').first;
    }

    if (songArtist.contains(' & ')) {
      songArtist = songArtist.split(' & ').first;
    }

    return songArtist.trim();
  }

  Map<String, List<String>> _extractTitleAndArtist(List<Video> rawVideos) {
    Map<String, List<String>> videos = {};
    String videoTitle;
    String videoAuthor;
    String songTitle;
    String songArtist;

    rawVideos.forEach((video) {
      videoTitle = video.title.toLowerCase();
      videoAuthor = video.author.toLowerCase();

      if (videoTitle.contains(' - ') || videoTitle.contains(' ~ ') || videoTitle.contains(' – ') || videoTitle.contains(' — ')) {
        final result = _getSongAndArtistFromTitle(videoTitle);

        songArtist = _removeEverythingUnnecessaryFromArtist(result[0]);
        songTitle = result[1];
      }
      else {
        songTitle = videoTitle;
        songArtist = videoAuthor;

        if (songTitle.contains('$songArtist | ')) {
          songTitle = songTitle.split('$songArtist | ')[1];
        }
      }

      songArtist = _removeEverythingUnnecessaryFromArtist(songArtist);
      songTitle = _removeEverythingUnnecessaryFromSong(songTitle);

      print('::: SONG FOUND: $songArtist - $songTitle');

      if (videos.containsKey(songArtist))
        videos[songArtist].add(songTitle);
      else
        videos[songArtist] = [songTitle];
    });

    return videos;
  }

  ///
  /// Get the track title from a YouTube video title
  /// Returns a Map with the artist as key and a list with the song as value
  ///
  Map<String, List<String>> extract(List<Video> rawVideos) {
    return _extractTitleAndArtist(rawVideos);
  }

}