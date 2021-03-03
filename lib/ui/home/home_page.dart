import 'dart:async';

import 'package:autospotify/ui/auth/account_page.dart';
import 'package:autospotify/ui/auth/login_page.dart';
import 'package:autospotify/ui/auth/register_page.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/back_button_handle.dart';
import 'package:autospotify/utils/youtube_utils.dart';
import 'package:autospotify/widgets/back_button.dart';
import 'package:autospotify/widgets/button.dart';
import 'package:autospotify/widgets/dialogs.dart';
import 'package:autospotify/widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _spotifyUsernameController;
  TextEditingController _ytPlaylistUrlController;

  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
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

  @override
  void initState() {
    initialTimer();

    _user = _auth.currentUser;
    if (_user != null) {
      _isUserLoggedIn = true;
      _username = _user.displayName;
      _userEmail = _user.email;
      _userAvatarUrl = _user.photoURL;

      if (!_user.emailVerified) {
        //_isVerified = true;
        Timer.run(() => _showEmailVerifyDialog(context));
      }

      _provider = _user.providerData.elementAt(0).providerId;
    }

    if (_provider == 'google.com') {
      _isGoogleUser = true;
    }

    _spotifyUsernameController = new TextEditingController();
    _ytPlaylistUrlController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _spotifyUsernameController.dispose();
    _ytPlaylistUrlController.dispose();

    super.dispose();
  }

  void _showEmailVerifyDialog(BuildContext context) {
    showDialog(context: context,
      builder: (context) => VerifyEmailDialog(
        user: _user,
        email: _userEmail,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => BackButtonHandle.onBackButtonExit(context),
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            width: SizeConfig.widthMultiplier * 100,
            height: SizeConfig.heightMultiplier * 100,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: SizeConfig.heightMultiplier * 3.160806006,
                  right: SizeConfig.widthMultiplier * 6.111535523,
                  // Theme Change Button
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),        
                        icon: ThemeProvider.themeOf(context).id == 'light_theme' ? Icon(Icons.wb_sunny) : Icon(Icons.nightlight_round),
                        color: ThemeProvider.themeOf(context).id == 'light_theme' ? Colors.yellow : Colors.grey,
                        tooltip: ThemeProvider.themeOf(context).id == 'light_theme' ? 'Activate Dark Theme' : 'Activate Light Theme',
                        onPressed: () => ThemeProvider.controllerOf(context).nextTheme(),
                      ),

                      Text(
                        '|',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      
                      Padding(padding: EdgeInsets.only(left: 10)),

                      // Account Button
                      FlatButton(
                        onPressed: () => {
                          if (_isUserLoggedIn) {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(child: AccountPage(), type: PageTransitionType.fade)
                            ),
                          }
                          else {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(child: LoginPage(), type: PageTransitionType.fade)
                            ),
                          }
                        },
                        //clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (_isUserLoggedIn && _isGoogleUser)
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  _userAvatarUrl,
                                ),
                                radius: 10,
                                backgroundColor: Colors.transparent,
                                onBackgroundImageError: (_,__) {
                                  setState(() {
                                    this._avatarLoadError = true;
                                  });
                                },
                                child: _avatarLoadError ? Icon(Icons.account_circle, color: Colors.grey, size: 20) : null,
                              )
                            else 
                              Icon(
                                Icons.account_circle,
                                color: Colors.grey,
                                size: 20
                              ),

                            Padding(padding: EdgeInsets.only(left: 5)),
                            Text(
                              (_isUserLoggedIn && _isGoogleUser) ? _username : _userEmail ?? 'Sign In',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Header Text
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
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
                        TextSpan(text: 'Add Songs from ',),
                        TextSpan(
                          text: 'YouTube',
                          style: TextStyle(
                            color: const Color(0xffff0000),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: '\nplaylists automatically\nto your ',),
                        TextSpan(
                          text: 'Spotify',
                          style: TextStyle(
                            color: const Color(0xff1db954),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: ' playlist',),
                        TextSpan(
                          text: '.',
                          style: TextStyle(
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // Lines
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  top: startAnimation ? SizeConfig.heightMultiplier * 38 : SizeConfig.heightMultiplier * 38,
                  right: startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
                  curve: Curves.ease,
                  child: SizedBox(
                    width: 256.0,
                    height: 0.0,
                    child: Stack(
                      children: <Widget>[
                        
                        // Green line
                        Align(
                          alignment: Alignment(92.0, 1.0),
                          child: Divider(
                            height: 0.0,
                            indent: 60.5,
                            endIndent: 145.5,
                            color: const Color(0xff1db954),
                            thickness: 4,
                          ),
                        ),
                        
                        // Red Line
                        Align(
                          alignment: Alignment(92.0, 1.0),
                          child: Divider(
                            height: 0.0,
                            indent: 12.5,
                            endIndent: 195.1,
                            color: const Color(0xffff0000),
                            thickness: 4,
                          ),
                        ),
                          
                        // AccentColor line
                        Align(
                          alignment: Alignment(164.0, 1.0),
                          child: Divider(
                            height: 0.0,
                            indent: 110.5,
                            endIndent: 20.5,
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            thickness: 4,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),

                // Spotify Username Input
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    alignment: Alignment.center,
                    child: SpotifyUsernameInputField(
                      controller: _spotifyUsernameController,
                      onEditingComplete: null, // TODO: Test connection when changed
                    ),
                  ),
                ),

                // YouTube Playlist Input
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  right: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 22),
                    alignment: Alignment.center,
                    child: YtPlaylistUrlInputField(
                      controller: _ytPlaylistUrlController,
                      onEditingComplete: () => YouTubeUtils().checkPlaylistId(_ytPlaylistUrlController.text, context), // TODO: Test connection when changed
                    ),
                  ),
                ),
                
                // Sync Button
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  bottom: SizeConfig.heightMultiplier * 20,
                  left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: CustomButton(
                    label: 'Sync',
                    onPressed: () => {
                      // TODO: Sync Playlists
                      YouTubeUtils().checkPlaylistId(_ytPlaylistUrlController.text, context)
                    },
                  ),
                ),
                
/* 
                // Back Button
                Positioned(
                  top: SizeConfig.heightMultiplier * 3.160806006,
                  left: SizeConfig.widthMultiplier * 0,
                  child: CustomBackButton(
                    onPressed: () => {
                      // Open prevoiuse indroduction page (package:autospotify/ui/introduction/introduction_spotify.dart)
                      Navigator.of(context).pushReplacement(
                        PageTransition(child: YouTubeIntroductionPage(), type: PageTransitionType.fade)
                      ),
                    },
                  ),
                ),
*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}