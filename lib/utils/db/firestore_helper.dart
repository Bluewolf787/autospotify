import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/spotify.dart';

class FirestoreHelper {

  // Get the Firestore Collection where all user documents get stored
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  ///
  /// Check if there is a document in Firestore for a specific user
  /// Returns a bool value
  ///
  Future<bool> _checkIfUserDocumentExists(String userId) async {
    bool _userDocumentExists = false;

    // Get user document
    await users
      .doc(userId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          _userDocumentExists = true;
        }
        else {
          _userDocumentExists = false;
        }
      })
      .onError((error, stackTrace) {
        print('Failed to check for user document: $error\nStackTrace:\n$stackTrace');
      });

    return _userDocumentExists;
  }

  ///
  /// Add a new user to Firestore
  /// 
  Future<void> addUser(String userId, String provider) async {
    bool _userAlreadyExists = await _checkIfUserDocumentExists(userId);

    if (_userAlreadyExists) {
      // User document already exists
      // Update user document
      await users.doc(userId).update({
        // Update the used provider
        'provider': provider
      })
      .then((value) => print('User document $userId updated'))
      .catchError((error) => print('Failed to update user in Firestore: $error'));
    }
    else {
      // User document does not exists
      // Create document with the ID of the user as name
      await users.doc(userId).set({
        // Save the used provider
        'provider': provider
      })
      .then((value) => print('New user added to Firestore'))
      .catchError((error) => print('Failed to add new user to Firestore: $error'));
    }
  }

  ///
  /// Save Spotify credentials to Firestore
  /// 
  Future<void> saveSpotifyCredentials(SpotifyApiCredentials credentials, String userId) async {
    // Create Map to store all Spotify credentials
    Map<String, dynamic> _spotifyCredentials = new Map<String, dynamic>();
    _spotifyCredentials['accessToken'] = credentials.accessToken;
    _spotifyCredentials['refreshToken'] = credentials.refreshToken;
    _spotifyCredentials['scopes'] = credentials.scopes;
    _spotifyCredentials['expiration'] = credentials.expiration;


    // Save the credentials in the user document
    await users.doc(userId).update({
      'spotify_credentials': _spotifyCredentials
    })
    .then((value) => print('Spotify credentials saved'))
    .onError((error, stackTrace) => print('Failed to save Spotify credentials $error\nStackTrace:\n$stackTrace'));
  }

  ///
  /// Get the Spotify credentials from Firestore
  /// Retruns a Map with all values needed to authenticate
  /// 
  Future<Map<String, dynamic>> getSpotifyCredentials(String userId) async {
    Map<String, dynamic> spotifyCredentials = new Map<String, dynamic>();

    // Gets Spotify Credentials from the user document
    await users
      .doc(userId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // Check if Spotify credentials are saved
          if (documentSnapshot.data().containsKey('spotify_credentials')) {
            // Save the Spotify credentials in the Map
            spotifyCredentials.addAll(documentSnapshot.data()['spotify_credentials']);
          }
          else {
            print('Spotify Credentials not found in Firestore document');
          }
        }
        else {
          print('Document does not exists (Failed getting: \'spotify_credentials\')');
        }
      })
      .onError((error, stackTrace) {
        print('Failed to get Spotify credentials $error\nStackTrace:\n$stackTrace');
      });

    return spotifyCredentials;
  }

  ///
  /// Save the Spotify playlist ID of the auto-generate playlist
  /// 
  Future<void> saveSpotifyPlaylistId(String playlistId, String userId) async {
    // Save the playlist ID of the auto-generated Spotify playlist in user doucment
    await users.doc(userId).update({
      'spotify_auto_playlist': playlistId
    })
    .then((value) => print('Spotify playlist ID saved'))
    .onError((error, stackTrace) => print('Failed to save Spotify playlist ID $error\nStackTrace:\n$stackTrace'));
  }

  ///
  /// Get the Spotify playlist ID of the auto-generated playlist
  /// Returns a the ID of the auto-generated Spotify playlist as String
  /// 
  Future<String> getSpotifyAutoPlaylistId(String userId) async {
    String playlistId = '';

    // Get the ID of the auto-generated Spotify playlist from the user document
    await users
      .doc(userId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // Check if the ID of the auto-generated Spotify playlist are saved
          if (documentSnapshot.data().containsKey('spotify_auto_playlist')) {
            playlistId = documentSnapshot.data()['spotify_auto_playlist'];
          }
        }
        else {
          print('Document does not exists (Failed getting: \'spotify_auto_playlist\')');
        }
      })
      .onError((error, stackTrace) {
        print('Failed to get Spotify playlist ID $error\nStackTrace:\n$stackTrace');
      });

    return playlistId;
  }

  ///
  /// Save the YouTube playlist URL to Firestore
  /// 
  Future<void> saveYouTubePlaylistUrl(String playlistUrl, String userId) async {
      // Save the YouTube playlist URL in the user document
      await users.doc(userId).update({
        'youtube_playlist': playlistUrl
      })
      .then((value) => print('YouTube playlist URL saved'))
      .onError((error, stackTrace) => print('Failed to save YouTube playlist URL $error\nStackTrace:\n$stackTrace'));
  }

  ///
  /// Get the YouTube playlist URL from Firestore
  /// Returns the saved YouTube playlist URL as String
  /// 
  Future<String> getYouTubePlaylistUrl(String userId) async {
    String playlistUrl = '';

    // Get the YouTube playlist URL from the user document
    await users
      .doc(userId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // Check if a YouTube playlist URL are saved
          if (documentSnapshot.data().containsKey('youtube_playlist')) {
            playlistUrl = documentSnapshot.data()['youtube_playlist'];
          }
          else {
            print('YouTube Playlist not found in Firestore document');
          }
        }
        else {
          print('Document does not exists (Failed getting: \'youtube_playlist\')');
        }
      })
      .onError((error, stackTrace) {
        print('Failed to get YouTube playlist URL $error\nStackTrace:\n$stackTrace');
      });

    return playlistUrl;
  }

}
