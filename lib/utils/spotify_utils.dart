import 'dart:convert';

import 'package:autospotify/ui/spotifyauth_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify/spotify.dart';

Future<SpotifyApi> connectToSpotify(BuildContext context) async { 

  // Get Client ID, Client Secret and Redirect Url from json
  Map spotifySecretsMap = await rootBundle.loadStructuredData('assets/spotify_secrets.json', (String data) async {
    return json.decode(data);
  });

  // Get Spotify credentials
  final credentials = SpotifyApiCredentials(spotifySecretsMap['clientID'], spotifySecretsMap['clientSecret']);

  final grant = SpotifyApi.authorizationCodeGrant(credentials);

  final redirectUri = spotifySecretsMap['redirectUrl'];

  // Define scopes
  final scopes = ['user-read-email', 'user-read-private', 'playlist-modify-private', 'playlist-modify-public'];

  // Create auth Url
  final authUri = grant.getAuthorizationUrl(
    Uri.parse(redirectUri),
    scopes: scopes,
  );

  // Open auth WebView
  final responseUri = await navigateToWebViewAndGetResponseUri(context, authUri.toString(), redirectUri);

  final spotify = SpotifyApi.fromAuthCodeGrant(grant, responseUri);

  return spotify;
}

navigateToWebViewAndGetResponseUri(BuildContext context, String initalUrl, String redirectUrl) async {
  final responseUrl = Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SpotifyAuthWebView(initalUrl: initalUrl, redirectUri: redirectUrl,))
  );

  return responseUrl;
}

createPrivatePlaylist(SpotifyApi spotify) async {
  var user = await spotify.me.get();
  await spotify.playlists.createPlaylist(
    user.id,
    'AutoPlaylist',
    description: 'Here you find all the songs you synced from YouTube playlists',
    public: false,
  ).then((playlist) {
    print('Private playlist created!');
  }).catchError(_prettyPrintError);
}

void _prettyPrintError(Object error) {
  if (error is SpotifyException) {
    print('${error.status} : ${error.message}');
  } else {
    print(error);
  }
}