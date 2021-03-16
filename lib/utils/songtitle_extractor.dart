class SongTitleExtractor {
  List<String> _removeRoundBrackets(List<String> rawVideos) {
    List<String> videos = [];
    rawVideos.forEach((video) {
      if (!(video.contains('(') && video.contains(')'))) {
        videos.add(video.trim());
        //print('::: No brackets $video');
      }
      
      if (video.contains('(') && video.contains(')')) {
        final firstPartTitle = video.split('(').first;
        final secondPartTitle = video.split(')').last;
        final videoTitle = firstPartTitle + secondPartTitle;
        //print('::: Round brackets $videoTitle');
        
        videos.add(videoTitle.trim());
      }
    });

    return videos;
  }

  List<String> _removeSquareBrackets(List<String> rawVideos) {
    List<String> videos = [];
    rawVideos.forEach((video) {
      if (!(video.contains('[') && video.contains(']'))) {
        videos.add(video.trim());
        //print('::: No brackets $video');
      }

      if (video.contains('[') && video.contains(']')) {
        final firstPartTitle = video.split('[').first;
        final secondPartTitle = video.split(']').last;
        final videoTitle = firstPartTitle + secondPartTitle;
        //print('::: Square brackets $videoTitle');
        
        videos.add(videoTitle.trim());
      }
    });

    return videos;
  }

  List<String> _getSongTitle(List<String> rawVideos) {
    List<String> videos = [];
    rawVideos.forEach((video) { 
      if (video.contains(' - ')) {
        videos.add(video.split(' - ').last.trim().toLowerCase());
      }
      else if (video.contains(' ~ ')) {
        videos.add(video.split(' ~ ').last.trim().toLowerCase());
      }
      else {
        videos.add(video.trim().toLowerCase());
      }
    });

    return videos;
  }

  List<String> extract(List<String> rawVideos) {
    final videosWithoutRoundBrackets = _removeRoundBrackets(rawVideos);
    final videosWithoutSquareBrackets = _removeSquareBrackets(videosWithoutRoundBrackets);
    final songTitles = _getSongTitle(videosWithoutSquareBrackets);

    return songTitles;
  }
}