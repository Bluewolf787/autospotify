import 'package:autospotify/ui/auth/login_page.dart';
import 'package:autospotify/utils/auth/fire_auth.dart';
import 'package:autospotify/utils/auth/google_auth.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/widgets/back_button.dart';
import 'package:autospotify/widgets/button.dart';
import 'package:autospotify/widgets/signin_button.dart';
import 'package:autospotify/widgets/snackbar.dart';
import 'package:autospotify/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;

  Duration _duration;
  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
    });
  }

  var _hidePassword = true;

  @override
  void initState() {
    super.initState();
    initialTimer();
    _duration = new Duration(seconds: 1);

    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
      body: Builder(
        builder: (context) =>
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.widthMultiplier * 100,
            child: Stack(
              children: <Widget>[
                // Header Text
                AnimatedPositioned(
                  duration: _duration,
                  top: startAnimation ? SizeConfig.heightMultiplier * 22 : SizeConfig.heightMultiplier * 22,
                  left: startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -80,
                  curve: Curves.ease,
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: ThemeProvider.themeOf(context).data.primaryColor,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(text: 'Register a new ',),
                        TextSpan(
                          text: 'Account',
                          style: TextStyle(
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: '.',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),  

                // Register with socials
                Positioned(
                  top: SizeConfig.heightMultiplier * 32,
                  child: AnimatedOpacity(
                    duration: _duration,
                    opacity: startAnimation ? 1.0 : 0.0,
                    curve: Curves.linear,
                    child: Container(
                      width: SizeConfig.widthMultiplier * 100,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Login with:',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ThemeProvider.themeOf(context).data.primaryColor,
                              height: 1.3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SignInButton(
                                onPressed: () async {
                                  // Sign user in with Google
                                  await GoogleAuth().signinWithGoogle().then((success) async {
                                    // Check if sign in was successfully
                                    if (success) {
                                      // Show success SnackBar
                                      CustomSnackbar.show(context, 'Successfully signed in with Google');
                                      // Wait two seconds
                                      await Future.delayed(const Duration(seconds: 2));
                                      // Close Register Page and open Home Page
                                      Navigator.of(context).pop();
                                    }
                                    else {
                                      CustomSnackbar.show(context, 'Oops! Something went wrong. May check your internet connection');
                                    }
                                  });
                                },
                                assetImage: 'assets/google_logo.png',
                                label: 'Google',
                                color: Colors.blue,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // E-Mail Input
                AnimatedPositioned(
                  duration: _duration,
                  left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * 100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    alignment: Alignment.center,
                    child: CustomTextField(
                      controller: _emailInputController,
                      readOnly: false,
                      obscureText: false,
                      hintText: 'Enter your E-Mail address',
                      labelText: 'E-Mail Address',
                      suffixIcon: Icon(
                        Icons.mail_rounded,
                        color: ThemeProvider.themeOf(context).data.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                // Password Input
                AnimatedPositioned(
                  duration: _duration,
                  left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 22),
                    alignment: Alignment.center,
                    child: CustomTextField(
                      controller: _passwordInputController,
                      readOnly: false,
                      obscureText: _hidePassword,
                      hintText: 'Enter a password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _hidePassword ? Icon(Icons.remove_red_eye_rounded) : Icon(Icons.remove_red_eye_outlined),
                        color: ThemeProvider.themeOf(context).data.primaryColor,
                        iconSize: 20,
                        tooltip: _hidePassword ? 'Show Password' : 'Hide Password',
                        onPressed: () {
                          setState(() {
                            _hidePassword ? _hidePassword = false : _hidePassword = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                // Register Button
                AnimatedPositioned(
                  duration: _duration,
                  bottom: SizeConfig.heightMultiplier * 20,
                  left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * 100,
                  curve: Curves.ease,
                  child: CustomButton(
                    label: 'Sign Up',
                    onPressed: () async {
                      if (_emailInputController.text.isEmpty) {
                        CustomSnackbar.show(context, 'Please enter a E-Mail address');
                        return;
                      }
                      if (_passwordInputController.text.isEmpty) {
                        CustomSnackbar.show(context, 'Please enter a password');
                        return;
                      }
                      await FireAuth().signUpWithEmailAndPassword(
                        context,
                        _emailInputController.text,
                        _passwordInputController.text,
                      ).then((success) {
                        if (success) {
                          showDialog(context: context,
                            builder: (context) =>
                            AlertDialog(
                              backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
                              title: Text(
                                'Account Signed Up!',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  color: ThemeProvider.themeOf(context).data.primaryColor,
                                  height: 1.3,
                                ),
                              ),
                              content: Text(
                                'You have successfully created a account for AutoSpotify.\n\nPlease verify your E-Mail address with the link we sent you to ${_emailInputController.text}.',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeProvider.themeOf(context).data.primaryColor,
                                  height: 1.3,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    // Close Register Page and open Home Page
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeProvider.themeOf(context).data.accentColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      });
                    },
                  ),
                ),

                // Go to LogIn button
                Positioned(
                  bottom: SizeConfig.heightMultiplier * 10,
                  child: AnimatedOpacity(
                    duration: _duration,
                    opacity: startAnimation ? 1.0 : 0.0,
                    curve: Curves.linear,
                    child: Container(
                      width: SizeConfig.widthMultiplier * 100,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          ButtonPressedHandler().pushToPage(context, LoginPage(), () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text(
                          'Already have one? Login',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Back Button
                Positioned(
                  top: SizeConfig.heightMultiplier * 3.160806006,
                  left: SizeConfig.widthMultiplier * 0,
                  child: AnimatedOpacity(
                    duration: _duration,
                    opacity: startAnimation ? 1.0 : 0.0,
                    curve: Curves.linear,
                    child: CustomBackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}