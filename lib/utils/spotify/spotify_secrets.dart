import 'dart:convert';

import 'package:flutter/services.dart';

class SpotifySecrets {
  Future<Map<String, dynamic>> get() async {
    // Get Client ID, Client Secret and Redirect Url from json
    Map<String, dynamic> spotifySecretsMap = await rootBundle.loadStructuredData('assets/spotify_secrets.json', (String data) async {
      return json.decode(data);
    });

    return spotifySecretsMap;
  } 
}