import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class GoogleAuth {

  Future<bool> signinWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication  googleAuth = await googleUser.authentication;

      final GoogleAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final User user = userCredential.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);
      }
      

      print('Google Sign in successful: ${user.uid} ${user.displayName}');
      return true;
    } catch (exception) {
      print('Google sign in: $exception');
      return false;
    }
  }

  Future<bool> googleSignOut() async {
    try {
      await googleSignIn.signOut();

      print('Google user signed out');
      return true;
    } catch (exception) {
      print('Google sign out: $exception');
      return false;
    }
  }
  
}
