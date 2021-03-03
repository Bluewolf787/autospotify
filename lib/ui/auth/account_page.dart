import 'package:autospotify/ui/home/home_page.dart';
import 'package:autospotify/ui/introduction/intro_start_page.dart';
import 'package:autospotify/utils/auth/fire_auth.dart';
import 'package:autospotify/utils/auth/google_auth.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/back_button_handle.dart';
import 'package:autospotify/widgets/back_button.dart';
import 'package:autospotify/widgets/snackbar.dart';
import 'package:autospotify/widgets/textfields.dart';
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

  @override
  void initState() {
    super.initState();
    initalTimer();

    _emailContoller = new TextEditingController();
    
    _user = _auth.currentUser;
    if (_user != null) {
      _isUserLoggedIn = true;
      _username = _user.displayName;
      _userEmail = _user.email;
      _userAvatarUrl = _user.photoURL;

      _emailContoller.text = _userEmail;

      _provider = _user.providerData.elementAt(0).providerId;
    }

    if (_provider == 'google.com') {
      _isGoogleUser = true;
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => onBackButtonExit(context),
      child: Scaffold(
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
                          obscureText: false,
                          labelText: 'E-Mail',
                          hintText: 'Your E-Mail Address',
                          prefixIcon: Icon(
                            Icons.mail_rounded,
                            color: Colors.grey,
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
                        child: OutlineButton.icon(
                          icon: Icon(
                            Icons.vpn_key_outlined,
                            size: 18,
                            color: Colors.grey,
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
                          highlightColor: ThemeProvider.themeOf(context).data.accentColor,
                          highlightedBorderColor: ThemeProvider.themeOf(context).data.accentColor,
                          disabledBorderColor: Colors.grey,
                          borderSide: BorderSide(
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          onPressed: () => {
                            if (_isGoogleUser) {
                              CustomSnackbar.show(context, 'You can not do this when signed in with Google',)
                            }
                            else {
                              // TODO Open Dialog
                            }
                          }, 
                        ),
                      ),
                    ),
                  ),

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
                        child: OutlineButton.icon(
                          icon: Icon(
                            Icons.book_outlined,
                            size: 18,
                            color: Colors.grey,
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
                          highlightColor: ThemeProvider.themeOf(context).data.accentColor,
                          highlightedBorderColor: ThemeProvider.themeOf(context).data.accentColor,
                          borderSide: BorderSide(
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                        child: OutlineButton.icon(
                          icon: Icon(
                            Icons.logout,
                            size: 18,
                            color: Colors.grey,
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
                          highlightColor: Colors.red,
                          highlightedBorderColor: Colors.red,
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          onPressed: () async {
                            // Sign user out
                            await userSignOut().then((success) async {
                              // Check if sign out was successfully
                              if (success) {
                                // Check if the user was signed in with Google
                                if (_isGoogleUser) {
                                  // Sign Google user out
                                  await googleSignOut();
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
                        child: OutlineButton.icon(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.grey,
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
                          highlightColor: Colors.red,
                          highlightedBorderColor: Colors.red,
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          onPressed: () async { 
                            await deleteUser().then((success) async {
                              if (success) {
                                // Check if the user was signed in with Google
                                if (_isGoogleUser) {
                                  // Sign Google user out
                                  await googleSignOut();
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
          ),
        ),
      ),
    );
  }
}