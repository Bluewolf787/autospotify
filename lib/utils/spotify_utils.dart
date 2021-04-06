import 'package:autospotify/ui/spotifyauth_webview.dart';
import 'package:autospotify/utils/firestore_helper.dart';
import 'package:autospotify/utils/spotify_secrets.dart';
import 'package:autospotify/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

class SpotifyUtils {

  ///
  /// Authenticate and connect to the user Spotify account
  /// Returns SpotifyApi object
  ///
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

    // Connect to user Spotify account
    final spotify = SpotifyApi.fromAuthCodeGrant(grant, responseUri);

    // Return SpotifyApi object
    return spotify;
  }

  ///
  /// Open a WebView with Spotify auth URL to authorize the user
  /// Returns the response URL from Spotify
  /// 
  Future<dynamic> _navigateToWebViewAndGetResponseUri(BuildContext context, String initalUrl, String redirectUrl) async {
    final responseUrl = Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpotifyAuthWebView(initalUrl: initalUrl, redirectUri: redirectUrl,))
    );

    // Return response URL
    return responseUrl;
  }

  ///
  /// Connect to the user Spotify accout using stored Spotify credentials
  /// Returns SpotifyApi object
  /// 
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

      // Connect user Spotify account using credentials
      final spotify = SpotifyApi(spotifyCredentials);

      // Save updated Spotify credentials
      await FirestoreHelper().saveSpotifyCredentials(await spotify.getCredentials(), userId);

      // Return SpotifyApi object
      return spotify;
    } catch (exception) {
      CustomSnackbar.show(context, 'Failed to connect to Spotify. Please reauthenticate.');
      return null;
    }

  }

  ///
  /// Get the current Spotify user
  /// Returns Spotify user
  /// 
  Future<User> getUser(SpotifyApi spotify) async {
    return await spotify.me.get();
  }

  ///
  /// Get all playlists from Spotify user
  /// Returns a Map from all playlists with playlist ID as key and playlist name as value
  ///
  Future<Map<String, String>> getAllPlaylists(SpotifyApi spotify) async {
    Map<String, String> playlistsMap = new Map<String, String>();

    // Get Spotify user
    User user = await getUser(spotify);

    // Get all playlists
    var playlistsIterable = await spotify.users.playlists(user.id).all();
    
    // Store playlists in Map
    playlistsIterable.forEach((playlistSimple) {
      playlistsMap[playlistSimple.id] = playlistSimple.name;
    });

    // Return Spotify playlists as Map<String, String> key: playlist ID, value playlist name
    return playlistsMap;
  }

  ///
  /// Create a private Spotify playlist (auto-generated playlist)
  /// 
  Future<void> createPlaylist(BuildContext context, SpotifyApi spotify, String userId) async {
    User user = await getUser(spotify);

    // Get ID of auto-generated Spotify playlist (if exists)
    String autoPlaylistId = await FirestoreHelper().getSpotifyAutoPlaylistId(userId);

    if (autoPlaylistId.isEmpty) {
      // Create playlist if does not exists
      await spotify.playlists.createPlaylist(
        user.id,
        'AutoPlaylist', // The name of the playlist
        description: 'Here you find all the songs you synced from YouTube playlists',
        public: false,
      ).then((Playlist playlist) {
        print('Private playlist created! ${playlist.href}');

        // Store playlist ID to Firestore
        FirestoreHelper().saveSpotifyPlaylistId(playlist.id, userId);
      }).catchError((error) => _printError(error));
    }
  }

  ///
  /// Search for tracks on Spotify
  /// Returns a list of Spotify track URIs
  ///
  Future<List<String>> searchSongs(SpotifyApi spotify, List<String> songTitles) async {
    List<String> tracks = [];
    List<BundledPages> searchResults = [];
    // Search for for each song title
    songTitles.forEach((song) {
      // Store search results in 'searchResults' list
      searchResults.add(spotify.search.get(song, types: {SearchType.track}));
    });

    Track track;
    // Check search result for every song title
    for (var result in searchResults) {
      await result.first().then((songs) {
        try {
          // Get first track from search result
          track = songs.first.items.first;
        } catch (exception) {
          print(exception);
        }
      }).whenComplete(() {
        // Store in 'tracks' list as Spotify track URI
        tracks.add('spotify:track:${track.id}');
      });
    }

    // Return Spotify tracks URIs as List<String> 
    return tracks;
  }

  ///
  /// Add tracks to a Spotify playlist
  ///
  Future<void> addSongsToPlaylist(BuildContext context, SpotifyApi spotify, List<String> trackList, String playlistId, String userId) async {
    if (playlistId.isEmpty) {
      // If no playlist ID provided use auto-generated playlist
      playlistId = await FirestoreHelper().getSpotifyAutoPlaylistId(userId);
    }

    // Add all tracks to the playlist
    await spotify.playlists.addTracks(trackList, playlistId).whenComplete(() {
      CustomSnackbar.show(context, 'Playlists successfully synced!');
    }).onError((error, stackTrace) => CustomSnackbar.show(context, 'Oops! Something went wrong while syncing.'));
  }

  ///
  /// Prints a formated error message
  ///
  void _printError(Object error) {
    if (error is SpotifyException) {
      print('${error.status} : ${error.message}');
    } else {
      print(error);
    }
  }

}
