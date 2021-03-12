import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/spotify.dart';

class FirestoreHelper {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// Add a new user to Firestore
  Future<void> addUser(String userId, String provider) async {
    // Only save when user is signed in
    if (userId != null) {
      // Create document with the ID of the user as name
      return await users.doc(userId).update({
        // Save the used provider
        'provider': provider
      })
      .then((value) => print('New user added to Firestore'))
      .catchError((error) => print('Failed to add new user to Firestore $error'));
    }
  }

  /// Save Spotify credentials to Firestore
  Future<void> saveSpotifyCredentials(SpotifyApiCredentials credentials, String userId) async {
    // Create Map to store all Spotify credentials
    Map<String, dynamic> _spotifyCredentials = new Map<String, dynamic>();
    _spotifyCredentials['accessToken'] = credentials.accessToken;
    _spotifyCredentials['refreshToken'] = credentials.refreshToken;
    _spotifyCredentials['scopes'] = credentials.scopes;
    _spotifyCredentials['expiration'] = credentials.expiration;

    // Only save when user is signed in
    if (userId != null) {
      // Save the credentials in the users document
      return await users.doc(userId).update({
        'spotify_credentials': _spotifyCredentials
      })
      .then((value) => print('Spotify credentials saved'))
      .onError((error, stackTrace) => print('Failed to save Spotify credentials $error\nStackTrace:\n$stackTrace'));
    }
  }

  /// Get the Spotify credentials from Firestore
  Future<Map<String, dynamic>> getSpotifyCredentials(String userId) async {
    Map<String, dynamic> spotifyCredentials = new Map<String, dynamic>();
    if (userId != null) {
      await users
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            spotifyCredentials.addAll(documentSnapshot.data()['spotify_credentials']);
          }
          else {
            print('Document does not exists');
          }
        })
        .onError((error, stackTrace) {
          print('Failed to get Spotify credentials $error\nStackTrace:\n$stackTrace');
        });
    }

    return spotifyCredentials;
  }

  /// Save the Spotify playlist ID of the auto-generate playlist
  Future<void> saveSpotifyPlaylistId(String playlistId, String userId) async {
    // Only save when user is signed in
    if (userId != null) {
      return await users.doc(userId).update({
        'spotify_auto_playlist': playlistId
      })
      .then((value) => print('Spotify playlist ID saved'))
      .onError((error, stackTrace) => print('Failed to save Spotify playlist ID $error\nStackTrace:\n$stackTrace'));
    }
  }

  /// Get the Spotify playlist ID of the auto-generated playlist
  Future<String> getSpotifyPlaylistId(String userId) async {
    String playlistId = '';
    if (userId != null) {
      await users
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            playlistId = documentSnapshot.data()['spotify_auto_playlist'];
          }
          else {
            print('Document does not exists');
          }
        })
        .onError((error, stackTrace) {
          print('Failed to get Spotify playlist ID $error\nStackTrace:\n$stackTrace');
        });
    }

    return playlistId;
  }

  /// Save the YouTube playlist URL to Firestore
  Future<void> saveYouTubePlaylistUrl(String playlistUrl, String userId) async {
    // Only save when user is signed in
    if (userId != null) {
      // Save the URL in the users document
      return await users.doc(userId).update({
        'youtube_playlist': playlistUrl
      })
      .then((value) => print('YouTube playlist URL saved'))
      .onError((error, stackTrace) => print('Failed to save YouTube playlist URL $error\nStackTrace:\n$stackTrace'));
    }
  }

  /// Get the YouTube playlist URL from Firestore
  Future<String> getYouTubePlaylistUrl(String userId) async {
    String playlistUrl = '';
    if (userId != null) {
      await users
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            playlistUrl = documentSnapshot.data()['youtube_playlist'];
          }
          else {
            print('Document does not exists');
          }
        })
        .onError((error, stackTrace) {
          print('Failed to get YouTube playlist URL $error\nStackTrace:\n$stackTrace');
        });
    }

    return playlistUrl;
  }

}
