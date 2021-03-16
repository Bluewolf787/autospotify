import 'package:autospotify/ui/spotifyauth_webview.dart';
import 'package:autospotify/utils/firestore_helper.dart';
import 'package:autospotify/utils/spotify_secrets.dart';
import 'package:autospotify/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

class SpotifyUtils {


  Future<SpotifyApi> connect(BuildContext context) async { 
    Map<String, dynamic> spotifySecretsMap = await SpotifySecrets().get();

    // Get Spotify credentials
    final credentials = SpotifyApiCredentials(spotifySecretsMap['clientID'], spotifySecretsMap['clientSecret']);

    // Get auth code grant
    final grant = SpotifyApi.authorizationCodeGrant(credentials);

    // Get redirect URI
    final redirectUri = spotifySecretsMap['redirectUrl'];

    // Define scopes
    final scopes = ['playlist-read-private', 'playlist-modify-private', 'playlist-modify-public'];

    // Create auth Url
    final authUri = grant.getAuthorizationUrl(
      Uri.parse(redirectUri),
      scopes: scopes,
    );

    // Open auth WebView
    final responseUri = await _navigateToWebViewAndGetResponseUri(context, authUri.toString(), redirectUri);

    final spotify = SpotifyApi.fromAuthCodeGrant(grant, responseUri);

    return spotify;
  }

  // Open a WebView with Spotify auth URL
  _navigateToWebViewAndGetResponseUri(BuildContext context, String initalUrl, String redirectUrl) async {
    final responseUrl = Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpotifyAuthWebView(initalUrl: initalUrl, redirectUri: redirectUrl,))
    );

    return responseUrl;
  }

  // Connect to Spotify user using saved credentials
  Future<SpotifyApi> connectWithCredentials(BuildContext context, String userId) async {
    Map<String, dynamic> spotifySecretsMap = await SpotifySecrets().get();
    Map<String, dynamic> credentials = await FirestoreHelper().getSpotifyCredentials(userId);
    
    try {
      // Get Spotify credentials
      final spotifyCredentials = SpotifyApiCredentials(
        spotifySecretsMap['clientID'],
        spotifySecretsMap['clientSecret'],
        accessToken: credentials['accessToken'],
        refreshToken: credentials['refreshToken'],
        scopes: credentials['scopes'].cast<String>(),
        expiration: credentials['expiration'].toDate()
      );

      final spotify = SpotifyApi(spotifyCredentials);

      await FirestoreHelper().saveSpotifyCredentials(await spotify.getCredentials(), userId);

      return spotify;
    } catch (exception) {
      CustomSnackbar.show(context, 'Failed to connect to Spotify. Please reauthenticate.');
      return null;
    }

  }

  // Get current Spotify user
  Future<User> getUser(SpotifyApi spotify) async {
    return await spotify.me.get();
  }

  Future<Map<String, String>> getAllPlaylists(SpotifyApi spotify) async {
    Map<String, String> playlistsMap = new Map<String, String>();

    User user = await getUser(spotify);

    var playlistsIterable = await spotify.users.playlists(user.id).all();
    
    playlistsIterable.forEach((playlistSimple) {
      playlistsMap[playlistSimple.id] = playlistSimple.name;
    });

    return playlistsMap;
  }

  // Create a private Spotify playlist
  Future<void> createPlaylist(BuildContext context, SpotifyApi spotify, String userId) async {
    User user = await getUser(spotify);

    String autoPlaylistId = await FirestoreHelper().getSpotifyAutoPlaylistId(userId);

    if (autoPlaylistId.isEmpty) {
      await spotify.playlists.createPlaylist(
        user.id,
        'AutoPlaylist', // The name of the playlist
        description: 'Here you find all the songs you synced from YouTube playlists',
        public: false,
      ).then((Playlist playlist) {
        print('Private playlist created! ${playlist.href}');

        // Save playlist ID to Firestore
        FirestoreHelper().saveSpotifyPlaylistId(playlist.id, userId);
      }).catchError((error) => _printError(error));
    }
  }

  Future<List<String>> searchSongs(SpotifyApi spotify, List<String> songTitles) async {
    List<String> tracks = [];
    List<BundledPages> searchResults = [];
    songTitles.forEach((song) {
      searchResults.add(spotify.search.get(song, types: {SearchType.track}));
    });

    Track track;
    for (var result in searchResults) {
      await result.first().then((songs) {
        try {
          track = songs.first.items.first;
        } catch (exception) {
          print(exception);
        }
      }).whenComplete(() {
        tracks.add('spotify:track:${track.id}');
      });
    }

    return tracks;
  }

  Future<void> addSongsToPlaylist(BuildContext context, SpotifyApi spotify, List<String> trackList, String playlistId, String userId) async {
    if (playlistId.isEmpty)
      playlistId = await FirestoreHelper().getSpotifyAutoPlaylistId(userId);

    await spotify.playlists.addTracks(trackList, playlistId).whenComplete(() {
      CustomSnackbar.show(context, 'Playlists successfully synced!');
    }).onError((error, stackTrace) => CustomSnackbar.show(context, 'Oops! Something went wrong while syncing.'));
  }

  void _printError(Object error) {
    if (error is SpotifyException) {
      print('${error.status} : ${error.message}');
    } else {
      print(error);
    }
  }

}
