import 'package:autospotify/ui/auth/register_page.dart';
import 'package:autospotify/utils/auth/fire_auth.dart';
import 'package:autospotify/utils/auth/google_auth.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/widgets/buttons/back_button.dart';
import 'package:autospotify/widgets/buttons/button.dart';
import 'package:autospotify/widgets/dialogs/dialogs.dart';
import 'package:autospotify/widgets/buttons/signin_button.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:autospotify/widgets/input/textfields.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;
  TextEditingController _forgotPasswordDialogController;

  Duration _duration;
  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(Duration(milliseconds: 500));
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
    _forgotPasswordDialogController = new TextEditingController();
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
                  top: SizeConfig.heightMultiplier * 22,
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
                        TextSpan(text: 'Sign In to your '),
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
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // Login with socials
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
                                onPressed: ()async {
                                  // Sign user in with Google
                                  await GoogleAuth().signinWithGoogle().then((success) async {
                                    // Check if sign in was successfully
                                    if (success) {
                                      // Show success SnackBar
                                      CustomSnackbar.show(context, 'Successfully signed in with Google');
                                      // Wait two seconds
                                      await Future.delayed(const Duration(seconds: 2));
                                      // Close Login Page and open Home Page
                                      Navigator.of(context).pop();
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
                      onEditingComplete: () => null,
                      readOnly: false,
                      passwordField: false,
                      emailField: true,
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
                      onEditingComplete: () => null,
                      readOnly: false,
                      passwordField: _hidePassword,
                      emailField: false,
                      hintText: 'Enter your password',
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

                // LogIn Button
                AnimatedPositioned(
                  duration: _duration,
                  bottom: SizeConfig.heightMultiplier * 20,
                  left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * 100,
                  curve: Curves.ease,
                  child: CustomButton(
                    label: 'Sign In',
                    onPressed: () async {
                      if (_emailInputController.text.isEmpty) {
                        CustomSnackbar.show(context, 'Please enter a E-Mail address');
                        return;
                      }
                      if (_passwordInputController.text.isEmpty) {
                        CustomSnackbar.show(context, 'Please enter a password');
                        return;
                      }
                      await FireAuth().signInWithEmailAndPassword(
                        context,
                        _emailInputController.text,
                        _passwordInputController.text,
                      ).then((success) async {
                        if (success) {
                          CustomSnackbar.show(context, 'Successfully Signed In');
                          // Wait two seconds
                          await Future.delayed(const Duration(seconds: 2));
                          // Close Sign In Page and open Home Page
                          Navigator.of(context).pop();
                        }
                      });
                    },
                  ),
                ),

                Positioned(
                  bottom: SizeConfig.heightMultiplier * 4,
                  child: AnimatedOpacity(
                    duration: _duration,
                    opacity: startAnimation ? 1.0 : 0.0,
                    curve: Curves.linear,
                    child: Container(
                      width: SizeConfig.widthMultiplier * 100,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Password Forgot Button
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ForgotPasswordDialog(
                                  controller: _forgotPasswordDialogController
                                )
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: ThemeProvider.themeOf(context).data.primaryColor,
                                height: 1.3,
                              ),
                            ),
                          ),
                          
                          // Go to Register Button
                          TextButton(
                            onPressed: () => {
                              ButtonPressedHandler().pushToPage(context, RegisterPage(), () {
                                Navigator.of(context).pop();
                              })
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith((states) {
                                return EdgeInsets.all(0);
                              }),
                            ),
                            child: Text(
                              'New at AutoSpotify? Sign Up',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: ThemeProvider.themeOf(context).data.primaryColor,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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