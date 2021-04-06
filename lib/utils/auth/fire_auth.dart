import 'package:autospotify/ui/auth/login_page.dart';
import 'package:autospotify/ui/auth/register_page.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class FireAuth {

  ///
  /// Sign Up a user using Firebase authentication with E-Mail and Password
  /// Returns a bool as success state
  ///
  Future<bool> signUpWithEmailAndPassword(BuildContext context, String email, String password) async {
    bool _isSignedUp = false;

    try {
      // Create a new user with E-Mail and Password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user
      final User user = userCredential.user;

      // Check if the user E-Mail is unverified
      if (!user.emailVerified) {
        // If the user E-Mail is unverified, send verification E-Mail
        await user.sendEmailVerification();
      }

      // Add user to Firestore
      await FirestoreHelper().addUser(user.uid, user.providerData.elementAt(0).providerId);

      print('User successful created: ${user.email}'); 

      // Sign Up was successful
      _isSignedUp = true;
    }on FirebaseAuthException catch (exception) {
      // An Firebase auth exception occurred

      if (exception.code == 'invalid-email') {
        // The provided E-Mail is invalid

        CustomSnackbar.show(context, 'Please enter a valid E-Mail address');

        print(exception.message);
        
        // The Sign Up prozess failed
        _isSignedUp = false;
      }
      else if (exception.code == 'weak-password') {
        // The provided password is too weak (less then 6 characters)

        print(exception.message);

        CustomSnackbar.show(context, 'Password too weak');
        // The Sign Up prozess failed
        _isSignedUp = false;
      } 
      else if (exception.code == 'email-already-in-use') {
        // The provided E-Mail is already used by another user account

        CustomSnackbar.show(
          context, 'Another account with this E-Mail address already exists',
          SnackBarAction(
            // Give the user the option to Sign In
            label: 'Sign In',
            textColor: ThemeProvider.themeOf(context).data.accentColor,
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                PageTransition(child: LoginPage(), type: PageTransitionType.fade)
              ),
            }
          ),
        );

        print(exception.message);

        // The Sign Up prozess failed
        _isSignedUp = false;
      }
    } catch (exception) {
      // An unexpected exception occurred

      CustomSnackbar.show(context, 'Oops! Something went wrong. Ma check your internet connection');

      print('Create user with email and password failed: $exception');
      
      // The Sign Up prozess failed
      _isSignedUp = false;
    }

    // Return Sign Up success state
    return _isSignedUp;
  }

  ///
  /// Sign In a user using Firebase with E-Mail and password
  /// Returns a bool as success state
  ///
  Future<bool> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    bool _isSignedIn = false;
    
    try {
      // Get user credentail from E-Mail and password account
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user
      final User user = userCredential.user;

      print('User sign in successful: ${user.email}');

      // Sign In was successful
      return true;
    } on FirebaseAuthException catch (exception) {
      // An Fireabse auth exception occurred

      if (exception.code == 'invalid-email') {
        // The provided E-Mail is invalid

        CustomSnackbar.show(context, 'Please enter a valid E-Mail address');

        print(exception.message);

        // The Sign In prozess failed
        _isSignedIn = false;
      }
      else if (exception.code == 'user-not-found') {
        // There is not registered user account with the provided E-Mail

        CustomSnackbar.show(
          context, 'No account found for that E-Mail',
          SnackBarAction(
            // Give the user the option to register a new account with that E-Mail
            label: 'Sign Up',
            textColor: ThemeProvider.themeOf(context).data.accentColor,
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                PageTransition(child: RegisterPage(), type: PageTransitionType.fade)
              ),
            }
          ),
        );
        
        print(exception.message);

        // The Sign In prozess failed
        _isSignedIn = false;
      }
      else if (exception.code == 'wrong-password') {
        // The provided password for this user account is wrong

        CustomSnackbar.show(
          context, 'Wrong password',
          SnackBarAction(
            // Give user the option to reset the password
            label: 'Forgot Password',
            textColor: ThemeProvider.themeOf(context).data.accentColor,
            onPressed: () => {
              null
              // TODO Open Dialog
            }
          ),
        );
        
        print(exception.message);

        // The Sign In prozess failed
        _isSignedIn = false;      
      }
    } catch (exception) {
      // An unexpected exception occurred

      print('User sign in with email and password: $exception');

      CustomSnackbar.show(context, 'Oops! Something went wrong. May check your internet connection');
      
      // The Sign In prozess failed
      _isSignedIn = false;
    }

    // Return the Sign In success state
    return _isSignedIn;
  }

  ///
  /// Sign Out users who Signed In with E-Mail and password
  /// Returns a bool as success state
  ///
  Future<bool> userSignOut(User user) async {
    try {
      print('User signed out ${user.uid}');

      // Sign Out user
      await _auth.signOut();

      // Sign Out was successful
      return true;
    } catch (exception) {
      // An unexpected exception occurred
      print('User sign out (${user.uid}): $exception');

      // Sign Out prozess failed
      return false;
    }

  }

  ///
  /// Password reset helper; Send Firebase password reset E-Mail
  /// Returns a bool as success state
  ///
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      // Try to send passwaord reset mail
      await _auth.sendPasswordResetEmail(email: email);

      print('Send password reset mail');

      // Send mail was successful
      return true;
    } catch (exception) {
      // An unexpected exception occurred

      print('Send password reset mail: $exception');

      // Send password reset mail failed
      return false;
    }
  }

  ///
  /// Delete user entrys
  /// Returns a bool as success state
  ///
  Future<bool> deleteUser(User user) async {    
    try {
      print('User deleted: ${user.uid}');

      // Delete user
      await user.delete();

      // User delete was successful
      return true;
    } catch (exception) {
      // An unexpected exception occurred

      print('User delete (${user.uid}): $exception');
      
      // User delete prozess failed
      return false;
    }
  }
  
}
