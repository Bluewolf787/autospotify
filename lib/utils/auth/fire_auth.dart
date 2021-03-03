import 'package:autospotify/ui/auth/login_page.dart';
import 'package:autospotify/ui/auth/register_page.dart';
import 'package:autospotify/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<bool> signUpWithEmailAndPassword(BuildContext context, String email, String password) async {
  try {
    print('$email\n$password');

    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;
    String _email;
    if (user != null) {
      _email = user.email;
    }

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }

    print('User successful created: $_email'); 
    return true;
  } on FirebaseAuthException catch (exception) {
    if (exception.code == 'invalid-email') {
      print(exception.message);

      CustomSnackbar.show(context, 'Please enter a valid E-Mail address');
      return false;
    }
    else if (exception.code == 'weak-password') {
      print(exception.message);

      CustomSnackbar.show(context, 'Password too weak');
      return false;
    } 
    else if (exception.code == 'email-already-in-use') {
      print(exception.message);

      CustomSnackbar.show(
        context, 'Another account with this E-Mail address already exists',
        SnackBarAction(
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
      return false;
    }
  } catch (exception) {
    print('Create user with email and password: $exception');

    CustomSnackbar.show(context, 'Oops! Something went wrong. Ma check your internet connection');
    return false;
  }
}

Future<bool> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
  try {
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;
    String _email;
    if (user != null) {
      _email = user.email;
    }

    print('User sign in successful: $_email');
    return true;
  } on FirebaseAuthException catch (exception) {
    if (exception.code == 'invalid-email') {
      print(exception.message);

      CustomSnackbar.show(context, 'Please enter a valid E-Mail address');
      return false;
    }
    else if (exception.code == 'user-not-found') {
      print(exception.message);

      CustomSnackbar.show(
        context, 'No account found for that E-Mail',
        SnackBarAction(
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
      return false;
    }
    else if (exception.code == 'wrong-password') {
      print(exception.message);

      CustomSnackbar.show(
        context, 'Wrong password',
        SnackBarAction(
          label: 'Forgot Password',
          textColor: ThemeProvider.themeOf(context).data.accentColor,
          onPressed: () => {
            null
          }
        ),
      );
      return false;      
    }
  } catch (exception) {
    print('User sign in with email and password: $exception');

    CustomSnackbar.show(context, 'Oops! Something went wrong. May check your internet connection');
    return false;
  }
}

Future<bool> userSignOut() async {
  User user = _auth.currentUser;

  try {
    print('User signed out ${user.uid}');
    await _auth.signOut();

    return true;
  } catch (exception) {
    print('User sign out (${user.uid}): $exception');
    return false;
  }

}

Future<bool> deleteUser() async {
  User user = _auth.currentUser;
  
  try {
    print('User deleted: ${user.uid}');
    await user.delete();

    return true;
  } catch (exception) {
    print('User delete (${user.uid}): $exception');
    return false;
  }
}