import 'package:autospotify/utils/db/shared_prefs_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/spotify.dart';
import 'package:uuid/uuid.dart';

class FirestoreHelper {

  // Get the Firestore Collection where all user documents get stored
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  ///
  /// Add a new user document to Firestore
  /// 
  Future<void> addUser() async {
    // Generate a random UUID
    String uuid = Uuid().v4();

    // Create a user document with the generated uuid
    await users.doc(uuid).set({
      'uuid': uuid
    })
    .then((_) {
      print('New user document created in Firestore [$uuid]');
    })
    .onError((error, stackTrace) {
      print('Failed to create new user document in Firestore [$uuid]: $error, StackTrace:\n$stackTrace');
    });

    // Save uuid with Shared Preferences
    await SharedPreferencesHelper().saveUuid(uuid);
  }

  ///
  /// Update Spotify credentials in Firestore
  ///
  Future<bool> _updateSpotifyCredentails(SpotifyApiCredentials credentials, String document) async {
    bool success = false;

    // Create Map to store all Spotify credentials
    Map<String, dynamic> _spotifyCredentials = new Map<String, dynamic>();
    _spotifyCredentials['accessToken'] = credentials.accessToken;
    _spotifyCredentials['refreshToken'] = credentials.refreshToken;
    _spotifyCredentials['scopes'] = credentials.scopes;
    _spotifyCredentials['expiration'] = credentials.expiration;

    // Update the credentials in the user document
    await users
      .doc(document)
      .update({
        'spotify_credentials': _spotifyCredentials
      })
      .then((_) {
        print('Spotify credentials saved');
        success = true;
      })
      .onError((error, stackTrace) {
        print('Failed to save Spotify credentials $error\nStackTrace:\n$stackTrace');
        success = false;
      });

    return success;
  }

  ///
  /// Save Spotify credentials
  /// Returns a bool as success state
  /// 
  Future<bool> saveSpotifyCredentials(SpotifyApiCredentials credentials, String userId) async {
    if (userId == null) {
      // User isn't signed in
      // Get uuid from Shared Prefs
      String uuid = await SharedPreferencesHelper().getUuid();

      // Save the credentials in the user document
      return await _updateSpotifyCredentails(credentials, uuid);
    }
    else {
      // User signed in
      
      // Save the credentials in the user document
      return await _updateSpotifyCredentails(credentials, userId);
    }
  }

  ///
  /// Query the Spotify credentials from Firestore
  ///
  Future<Map<String, dynamic>> _querySpotifyCredentials(String document) async {
    Map<String, dynamic> spotifyCredentials = new Map<String, dynamic>();

    // Gets Spotify Credentials from the user document
    await users
      .doc(document)
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
  /// Retruns a Map with all values needed to authenticate
  /// 
  Future<Map<String, dynamic>> getSpotifyCredentials(String userId) async {
    if (userId == null) {
      // User isn't sigend in
      // Get uuid from Shared Prefs
      String uuid = await SharedPreferencesHelper().getUuid();

      // Get Spotify Credentails
      return await _querySpotifyCredentials(uuid);
    }
    else {
      // User is signed in
      
      // Get Spotify Credentails
      return await _querySpotifyCredentials(userId);
    }
  }

  ///
  /// Update the Spotify playlist ID of the auto-generate playlist in Firestore
  ///
  Future<void> _updateSpotifyPlaylistId(String playlistId, String document) async {
    // Update the playlist ID in user doucment
    await users
    .doc(document)
    .update({
      'spotify_auto_playlist': playlistId
    })
    .then((_) {
      print('Spotify playlist ID saved');
    })
    .onError((error, stackTrace) {
      print('Failed to save Spotify playlist ID $error\nStackTrace:\n$stackTrace');
    });
  }

  ///
  /// Save the ID of the auto-generated Spotify playlist
  /// 
  Future<void> saveSpotifyPlaylistId(String playlistId, String userId) async {
    
    if (userId == null) {
      // User isn't signed in
      // Get uuid from Shared Prefs
      String uuid = await SharedPreferencesHelper().getUuid();

      // Save the playlist ID of the auto-generated Spotify playlist in user doucment
      await _updateSpotifyPlaylistId(playlistId, uuid);
    }
    else {
      // User is signed in
      
      // Save the playlist ID of the auto-generated Spotify playlist in user doucment
      await _updateSpotifyPlaylistId(playlistId, userId);
    }
  }

  ///
  /// Query the Spotify playlist ID of the auto-generated playlist from Firestore
  ///
  Future<String> _querySpotifyAutoPlaylistId(String document) async {
    String playlistId = '';

    // Query the playlist ID from the user document
    await users
      .doc(document)
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
  /// Get the Spotify playlist ID
  /// Returns a the ID of the auto-generated Spotify playlist as String
  /// 
  Future<String> getSpotifyAutoPlaylistId(String userId) async {
    if (userId == null) {
      // User isn't signed in
      // Get uuid from Shared Prefs
      String uuid = await SharedPreferencesHelper().getUuid();

      // Get the playlist ID
      return await _querySpotifyAutoPlaylistId(uuid);
    }
    else {
      // User is signed in
       
      // Get the playlist ID
      return await _querySpotifyAutoPlaylistId(userId);
    }
  }

  ///
  /// Updatethe YouTube playlist URL in Firestore
  ///
  Future<void> _updateYouTubePlaylistUrl(String playlistUrl, String document) async {
    // Update the YouTube playlist URL in the user document
    await users
      .doc(document)
      .update({
        'youtube_playlist': playlistUrl
      })
      .then((_) {
        print('YouTube playlist URL saved');
      })
      .onError((error, stackTrace) {
        print('Failed to save YouTube playlist URL $error\nStackTrace:\n$stackTrace');
      });
  }

  ///
  /// Save the YouTube playlist URL
  /// 
  Future<void> saveYouTubePlaylistUrl(String playlistUrl, String userId) async {
    if (userId == null) {
      // User isn't signed in
      // Get uuid from Shared Prefs
      String uuid = await SharedPreferencesHelper().getUuid();
      
      // Save the YouTube playlist URL
      await _updateYouTubePlaylistUrl(playlistUrl, uuid);
    }
    else {
      // User is signed id
      
      // Save the YouTube playlist URL in the user document
      await _updateYouTubePlaylistUrl(playlistUrl, userId);
    }
  }

  ///
  /// Query the YouTube playlist URL from Firestore
  ///
  Future<String> _queryYouTubePlaylistUrl(String document) async {
    String playlistUrl = '';

    // Query the YouTube playlist URL from the user document
    await users
      .doc(document)
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

  ///
  /// Get the YouTube playlist URL 
  /// Returns the saved YouTube playlist URL as String
  /// 
  Future<String> getYouTubePlaylistUrl(String userId) async {
    if (userId == null) {
      // User isn't signed in
      // Get uuid from Shared Prefs
      String uuid = await SharedPreferencesHelper().getUuid();

      // Get the playlist URL
      return await _queryYouTubePlaylistUrl(uuid);
    }
    else {
      // User is signed in
      
      // Get the playlist URL
      return await _queryYouTubePlaylistUrl(userId);
    }
  }

}
