import 'package:autospotify/ui/auth/register_page.dart';
import 'package:autospotify/ui/introduction/choose_theme_page.dart';
import 'package:autospotify/ui/introduction/introduction_spotify.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/widgets/buttons/back_button.dart';
import 'package:autospotify/widgets/buttons/button.dart';
import 'package:autospotify/widgets/layout/circles.dart';
import 'package:autospotify/widgets/layout/introduction_page_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({Key key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  final _duration = Duration(seconds: 1);
  var _startAnimation = false;
  initalTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _startAnimation = true;
    });
  }

  User _user;
  var _isUserLoggedIn = false;
  String _userId;
  String _username;
  String _userEmail;
  String _userAvatarUrl;

  var _avatarLoadError = false;

  String _provider;
  var _isGoogleUser = false;

  @override
  void initState() {
    super.initState();

    initalTimer();
  }

  void refresh() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    if (_user != null) {
      _isUserLoggedIn = true;
      _userId = _user.uid;
      _username = _user.displayName;
      _userEmail = _user.email;
      _userAvatarUrl = _user.photoURL;

      _provider = _user.providerData.elementAt(0).providerId;
    }

    if (_provider == 'google.com') {
      _isGoogleUser = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => ButtonPressedHandler().onBackButtonExit(context),
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.widthMultiplier * 100,
            child: Stack(
              children: <Widget>[
                // Circle frame 1
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  top: _startAnimation ? SizeConfig.heightMultiplier * -2 : SizeConfig.heightMultiplier * -20,
                  right: _startAnimation ? SizeConfig.widthMultiplier * -14 : SizeConfig.widthMultiplier * -55,
                  curve: Curves.ease,
                  child: Circle(
                    diameter: 194,
                    color: ThemeProvider.themeOf(context).data.accentColor,
                    notFilled: true,
                  ),
                ),

                // Circle frame 2
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  top: _startAnimation ? SizeConfig.heightMultiplier * -11 : SizeConfig.heightMultiplier * -40,
                  right: _startAnimation ? SizeConfig.widthMultiplier * -6 : SizeConfig.widthMultiplier * 10,
                  curve: Curves.ease,
                  child: Circle(
                    diameter: 210,
                    color: ThemeProvider.themeOf(context).data.accentColor,
                    notFilled: true,
                  ),
                ),

                // Circle frame 3
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  top: _startAnimation ? SizeConfig.heightMultiplier * -5 : SizeConfig.heightMultiplier * 10,
                  right: _startAnimation ? SizeConfig.widthMultiplier * -33 : SizeConfig.widthMultiplier * -120,
                  curve: Curves.ease,
                  child: Circle(
                    diameter: 296,
                    color: ThemeProvider.themeOf(context).data.accentColor,
                    notFilled: true,
                  ),
                ),

                // Header Text
                AnimatedPositioned(
                  duration: _duration,
                  top: _startAnimation ? SizeConfig.heightMultiplier * 22 : SizeConfig.heightMultiplier * 22,
                  left: _startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -80,
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
                        TextSpan(text: 'Create a '),
                        TextSpan(
                          text: 'Account',
                          style: TextStyle(
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: ' to save\nyour '),
                        TextSpan(
                          text: 'Data',
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
                  ),
                ),

                // User avatar and name (email) shows when signed in
                Positioned(
                  right: SizeConfig.widthMultiplier * 10,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: _isUserLoggedIn ? 1.0 : 0.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (_isUserLoggedIn && _isGoogleUser)
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  _userAvatarUrl,
                                ),
                                radius: 60,
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
                            
                            Padding(padding: EdgeInsets.only(bottom: 10)),
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

                // Go To Register Button
                AnimatedPositioned(
                  duration: _duration,
                  right: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: _isUserLoggedIn ? 0.0 : 1.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 8,
                            width: SizeConfig.widthMultiplier * 80,
                            child: OutlinedButton(
                              child: Text(
                                'Register a new account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeProvider.themeOf(context).data.primaryColor,
                                ),
                              ),
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith((states) {
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
                              onPressed: () {
                                ButtonPressedHandler().pushToPage(context, RegisterPage(), () {
                                  setState(() {
                                    refresh();                                   
                                  });
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Next Button
                AnimatedPositioned(
                  duration: _duration,
                  bottom: SizeConfig.heightMultiplier * 20,
                  left: _startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: CustomButton(
                    label: 'Next',
                    onPressed: () async {
                      FirestoreHelper().addUser(_userId, _provider);
                      ButtonPressedHandler().pushAndReplaceToPage(context, SpotifyIntroductionPage());
                    },
                  ),
                ),

                // Page Number
                PageIndicator(
                  currentPage: 2,
                  maxPages: 4,
                ),

                // Back Button
                Positioned(
                  top: SizeConfig.heightMultiplier * 3.160806006,
                  left: SizeConfig.widthMultiplier * 0,
                  child: AnimatedOpacity(
                    duration: _duration,
                    opacity: _startAnimation ? 1.0 : 0.0,
                    curve: Curves.linear,
                    child: CustomBackButton(
                      onPressed: () {
                        ButtonPressedHandler().pushAndReplaceToPage(context, ChooseThemePage());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}