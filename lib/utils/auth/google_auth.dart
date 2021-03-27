import 'package:autospotify/utils/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class GoogleAuth {

  ///
  /// User authentication with Firebase using Google
  /// Returns a bool value as success state
  ///
  Future<bool> signinWithGoogle() async {
    try {
      // Sign In user with Google
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();

      // Authenticate user with Google
      final GoogleSignInAuthentication  googleAuth = await googleUser.authentication;

      // Get Google credentials from Goole authentication
      final GoogleAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Get user credentials from Google auth credentials
      final UserCredential userCredential = await _auth.signInWithCredential(googleAuthCredential);

      // Get user
      final User user = userCredential.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);
      }
      
      // Store new user in Firestore
      await FirestoreHelper().addUser(user.uid, user.providerData.elementAt(0).providerId);

      print('Google Sign in successful: ${user.uid} ${user.displayName}');

      // Authentication with Google was successful
      return true;
    } catch (exception) {
      // An unexpected exception occurred

      print('Google sign in: $exception');

      // Authentication with Google failed
      return false;
    }
  }

  ///
  /// Sign Out users who authenticate with Google
  /// Returns a bool value as success state
  ///
  Future<bool> googleSignOut() async {
    try {

      // Sign Out Goole user
      await googleSignIn.signOut();

      print('Google user signed out');

      // Sign Out prozess was successful
      return true;
    } catch (exception) {
      // An unexpected exception occurred

      print('Google sign out: $exception');

      // Sign Out prozess failed
      return false;
    }
  }
  
}
