import 'package:autospotify/ui/home/home_page.dart';
import 'package:autospotify/ui/introduction/intro_start_page.dart';
import 'package:autospotify/utils/auth/fire_auth.dart';
import 'package:autospotify/utils/auth/google_auth.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/widgets/buttons/back_button.dart';
import 'package:autospotify/widgets/dialogs/dialogs.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:autospotify/widgets/input/textfields.dart';
import 'package:autospotify/widgets/layout/no_network_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  TextEditingController _emailContoller;

  var _startAnimation = false;
  initalTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _startAnimation = true;
    });
  }

  User _user;
  var _isUserLoggedIn = false;
  String _username;
  String _userEmail;
  String _userAvatarUrl;

  var _avatarLoadError = false;

  String _provider;
  var _isGoogleUser = false;

  void getUserData() {
    _user = _auth.currentUser;
    if (_user != null) {
      _isUserLoggedIn = true;
      _username = _user.displayName;
      _userEmail = _user.email;
      _userAvatarUrl = _user.photoURL;

      _emailContoller.text = _userEmail;

      _provider = _user.providerData.elementAt(0).providerId;
    
      if (_provider == 'google.com') {
        _isGoogleUser = true;
      }
    }

  }

  @override
  void initState() {
    super.initState();
    initalTimer();

    _emailContoller = new TextEditingController();

    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => ButtonPressedHandler().onBackButtonExit(context),
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: Builder(
          builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                getUserData();
              },
              backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
              color: ThemeProvider.themeOf(context).data.accentColor,
              displacement: SizeConfig.heightMultiplier * 5,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NoNetworkConnection(),
                    Container(
                      height: SizeConfig.heightMultiplier * 100,
                      width: SizeConfig.widthMultiplier * 100,
                      child: Stack(
                        children: <Widget>[
                          // Top Lines
                          AnimatedPositioned(
                            duration: Duration(seconds: 1,),
                            top: _startAnimation ? SizeConfig.heightMultiplier * 20 : SizeConfig.heightMultiplier * 20,
                            left: _startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
                            curve: Curves.ease,
                            child: SizedBox(
                              width: 236.0,
                              height: 0.0,
                              child: Stack(
                                children: <Widget>[
                                  // Blue line
                                  Align(
                                    alignment: Alignment(164.0, 1.0),
                                    child: Divider(
                                      height: 0.0,
                                      indent: 22.5,
                                      endIndent: 9.5,
                                      color: Colors.blue,
                                      thickness: 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: SizeConfig.heightMultiplier * 22,
                            child: Container(
                              width: SizeConfig.widthMultiplier * 100,
                              height: SizeConfig.heightMultiplier * 23.5,
                              alignment: Alignment.center,
                              child: AnimatedOpacity(
                                duration: Duration(seconds: 1,),
                                opacity: _startAnimation ? 1.0 : 0.0,
                                curve: Curves.linear,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      if (_isUserLoggedIn && _isGoogleUser)
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            _userAvatarUrl,
                                          ),
                                          radius: SizeConfig.widthMultiplier * 15,
                                          backgroundColor: Colors.transparent,
                                          onBackgroundImageError: (_,__) {
                                            setState(() {
                                              this._avatarLoadError = true;
                                            });
                                          },
                                          child: _avatarLoadError ? Icon(Icons.account_circle_rounded, size: 124, color: Colors.grey,) : null,
                                        )
                                      else
                                        Icon(
                                          Icons.account_circle_rounded,
                                          size: 124,
                                          color: Colors.grey,
                                        ),
                                      
                                      Padding(padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1)),
                                      Text(
                                        (_isUserLoggedIn && _isGoogleUser) ? _username : _userEmail ?? 'Your Account',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeProvider.themeOf(context).data.primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Bottom Lines
                          AnimatedPositioned(
                            duration: Duration(seconds: 1,),
                            top: _startAnimation ? SizeConfig.heightMultiplier * 48 : SizeConfig.heightMultiplier * 48,
                            right: _startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
                            curve: Curves.ease,
                            child: SizedBox(
                              width: 236.0,
                              height: 0.0,
                              child: Stack(
                                children: <Widget>[
                                  // Blue line
                                  Align(
                                    alignment: Alignment(164.0, 1.0),
                                    child: Divider(
                                      height: 0.0,
                                      indent: 12.5,
                                      endIndent: 20.5,
                                      color: Colors.blue,
                                      thickness: 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Email Box
                          AnimatedPositioned(
                            duration: Duration(seconds: 1,),
                            left: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                            curve: Curves.ease,
                            child: Container(
                              height: SizeConfig.heightMultiplier * 100,
                              width: SizeConfig.widthMultiplier * 80,
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 15),
                              alignment: Alignment.center,
                              child: Container(
                                child: CustomTextField(
                                  controller: _emailContoller,
                                  onEditingComplete: () => null, // TODO Alert that email is changed
                                  readOnly: _isGoogleUser ? true : false,
                                  passwordField: false,
                                  emailField: true,
                                  labelText: 'E-Mail',
                                  hintText: 'Your E-Mail Address',
                                  prefixIcon: Icon(
                                    Icons.mail_rounded,
                                    color: ThemeProvider.themeOf(context).data.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Change Password Button
                          AnimatedPositioned(
                            duration: Duration(seconds: 1,),
                            right: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                            curve: Curves.ease,
                            child: Container(
                              height: SizeConfig.heightMultiplier * 100,
                              width: SizeConfig.widthMultiplier * 80,
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 35),
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: SizeConfig.heightMultiplier * 8,
                                width: SizeConfig.widthMultiplier * 80,
                                child: OutlinedButton.icon(
                                  icon: Icon(
                                    Icons.vpn_key_outlined,
                                    color: ThemeProvider.themeOf(context).data.primaryColor,
                                    size: 18,
                                  ),
                                  label: Text(
                                    'Change Password',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeProvider.themeOf(context).data.primaryColor,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return ThemeProvider.themeOf(context).data.primaryColor;
                                      }

                                      return Colors.grey;
                                    }),
                                    overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.grey;
                                      }
                                      
                                      return ThemeProvider.themeOf(context).data.accentColor;
                                    }),
                                    side: MaterialStateProperty.resolveWith((states) {
                                      return BorderSide(
                                        color: ThemeProvider.themeOf(context).data.accentColor,
                                        width: 2.0,
                                      );
                                    }),
                                    shape: MaterialStateProperty.resolveWith((states) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      );
                                    }),
                                  ),
                                  onPressed: () async {
                                    // Check if user is Signed In
                                    if (_user == null)
                                      return;

                                    // Check if user is Signed in via Google
                                    if (_isGoogleUser) {
                                      CustomSnackbar.show(context, 'You can not do this when signed in with Google');
                                      return;
                                    }
                                    
                                    // Check if user verified the E-Mail
                                    if (!_user.emailVerified)
                                    {
                                      // Show Dialog if not verified
                                      showDialog(context: context,
                                        builder: (context) => VerifyEmailDialog(
                                          user: _user,
                                          email: _userEmail,
                                        ),
                                      );
                                      return;
                                    }

                                    await FireAuth().sendPasswordResetEmail(_userEmail).then((success) {
                                      if (success) {
                                        CustomSnackbar.show(context, 'We sent you a E-Mail to reset your password');
                                      }
                                      else {
                                        CustomSnackbar.show(context, 'Oops! Something went wrong. Please try again');
                                      }
                                    });
                                  }, 
                                ),
                              ),
                            ),
                          ),

                          // Line
                          AnimatedOpacity(
                            duration: Duration(seconds: 1,),
                            opacity: _startAnimation ? 1.0 : 0.0,
                            curve: Curves.linear,
                            child: Container(
                              height: SizeConfig.heightMultiplier * 100,
                              width: SizeConfig.widthMultiplier * 80,
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 47),
                              alignment: Alignment.center,
                              child: Divider(
                                color: Colors.grey,
                                height: 1.0,
                                indent: 80,
                                endIndent: 20,
                              ),
                            ),
                          ),

                          // Show Intro again
                          AnimatedPositioned(
                            duration: Duration(seconds: 1,),
                            left: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                            curve: Curves.ease,
                            child: Container(
                              height: SizeConfig.heightMultiplier * 100,
                              width: SizeConfig.widthMultiplier * 80,
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 57),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: SizeConfig.widthMultiplier * 80,
                                child: OutlinedButton.icon(
                                  icon: Icon(
                                    Icons.book_outlined,
                                    color: ThemeProvider.themeOf(context).data.primaryColor,
                                    size: 18,
                                  ),
                                  label: Text(
                                    'Start introduction',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeProvider.themeOf(context).data.primaryColor,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return ThemeProvider.themeOf(context).data.primaryColor;
                                      }

                                      return Colors.grey;
                                    }),
                                    overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.grey;
                                      }
                                      
                                      return ThemeProvider.themeOf(context).data.accentColor;
                                    }),
                                    side: MaterialStateProperty.resolveWith((states) {
                                      return BorderSide(
                                        color: ThemeProvider.themeOf(context).data.accentColor,
                                        width: 2.0,
                                      );
                                    }),
                                    shape: MaterialStateProperty.resolveWith((states) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      );
                                    }),
                                  ),
                                  onPressed: () => {
                                    Navigator.pushReplacement(
                                      context,
                                      PageTransition(child: IntroStartPage(), type: PageTransitionType.fade)
                                    )
                                  },
                                ),
                              ),
                            ),
                          ),

                          // SignOut Button
                          AnimatedPositioned(
                            duration: Duration(seconds: 1,),
                            right: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                            curve: Curves.ease,
                            child: Container(
                              height: SizeConfig.heightMultiplier * 100,
                              width: SizeConfig.widthMultiplier * 80,
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 72),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: SizeConfig.widthMultiplier * 80,
                                child: OutlinedButton.icon(
                                  icon: Icon(
                                    Icons.logout,
                                    color: ThemeProvider.themeOf(context).data.primaryColor,
                                    size: 18,
                                  ),
                                  label: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeProvider.themeOf(context).data.primaryColor,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return ThemeProvider.themeOf(context).data.primaryColor;
                                      }

                                      return Colors.grey;
                                    }),
                                    overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.grey;
                                      }
                                      
                                      return Colors.red;
                                    }),
                                    side: MaterialStateProperty.resolveWith((states) {
                                      return BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      );
                                    }),
                                    shape: MaterialStateProperty.resolveWith((states) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      );
                                    }),
                                  ),
                                  onPressed: () async {
                                    // Sign user out
                                    await FireAuth().userSignOut(_user).then((success) async {
                                      // Check if sign out was successfully
                                      if (success) {
                                        // Check if the user was signed in with Google
                                        if (_isGoogleUser) {
                                          // Sign Google user out
                                          await GoogleAuth().googleSignOut();
                                        }
                                        // Show success SnackBar
                                        CustomSnackbar.show(context, 'Successfully signed out');
                                        // Wait two seconds
                                        await Future.delayed(const Duration(seconds: 2));
                                        // Close Account Page and open Home Page
                                        Navigator.pushReplacement(
                                          context,
                                          PageTransition(child: HomePage(), type: PageTransitionType.fade)
                                        );
                                      }
                                      else {
                                        // If an error occoured show error SnackBar
                                        CustomSnackbar.show(context, 'Oops! Something went wrong while sign out');
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),

                          // Delete Account Button 
                          AnimatedPositioned(
                            duration: Duration(seconds: 1,),
                            left: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                            curve: Curves.ease,
                            child: Container(
                              height: SizeConfig.heightMultiplier * 100,
                              width: SizeConfig.widthMultiplier * 80,
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 87),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: SizeConfig.widthMultiplier * 80,
                                child: OutlinedButton.icon(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: ThemeProvider.themeOf(context).data.primaryColor,
                                    size: 18,
                                  ),
                                  label: Text(
                                    'Delete Account',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ThemeProvider.themeOf(context).data.primaryColor,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return ThemeProvider.themeOf(context).data.primaryColor;
                                      }

                                      return Colors.grey;
                                    }),
                                    overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.grey;
                                      }
                                      
                                      return Colors.red;
                                    }),
                                    side: MaterialStateProperty.resolveWith((states) {
                                      return BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      );
                                    }),
                                    shape: MaterialStateProperty.resolveWith((states) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      );
                                    }),
                                  ),
                                  onPressed: () async { 
                                    await FireAuth().deleteUser(_user).then((success) async {
                                      if (success) {
                                        // Check if the user was signed in with Google
                                        if (_isGoogleUser) {
                                          // Sign Google user out
                                          await GoogleAuth().googleSignOut();
                                        }
                                        // Show success SnackBar
                                        CustomSnackbar.show(context, 'Account successfully deleted');
                                        // Wait two seconds
                                        await Future.delayed(const Duration(seconds: 2));
                                        // Close Account Page and open Home Page
                                        Navigator.pushReplacement(
                                          context,
                                          PageTransition(child: HomePage(), type: PageTransitionType.fade)
                                        );
                                      }
                                      else {
                                        // If an error occoured show error SnackBar
                                        CustomSnackbar.show(context, 'Oops! Something went wrong while sign out');
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),          

                          // Back Button
                          Positioned(
                            top: SizeConfig.heightMultiplier * 3.160806006,
                            left: SizeConfig.widthMultiplier * 0,
                            child: AnimatedOpacity(
                              duration: Duration(seconds: 1,),
                              opacity: _startAnimation ? 1.0 : 0.0,
                              curve: Curves.linear,
                              child: CustomBackButton(
                                onPressed: () => {
                                  // Open prevoiuse indroduction page (package:autospotify/ui/introduction/introduction_spotify.dart)
                                  Navigator.of(context).pushReplacement(
                                    PageTransition(child: HomePage(), type: PageTransitionType.fade)
                                  ),
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}