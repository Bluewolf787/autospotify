import 'package:autospotify/ui/introduction/create_account_page.dart';
import 'package:autospotify/ui/introduction/introduction_yt.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/spotify/spotify_connect_status.dart';
import 'package:autospotify/utils/spotify/spotify_utils.dart';
import 'package:autospotify/widgets/buttons/back_button.dart';
import 'package:autospotify/widgets/buttons/button.dart';
import 'package:autospotify/widgets/layout/circles.dart';
import 'package:autospotify/widgets/layout/introduction_page_indicator.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:autospotify/widgets/layout/no_network_connection.dart';
import 'package:autospotify/widgets/spotify_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify/spotify.dart';
import 'package:theme_provider/theme_provider.dart';

Firebase.FirebaseAuth _auth = Firebase.FirebaseAuth.instance;

class SpotifyIntroductionPage extends StatefulWidget {
  @override
  _SpotifyIntroductionPageState createState() => _SpotifyIntroductionPageState();
}

class _SpotifyIntroductionPageState extends State<SpotifyIntroductionPage> {
  
  TextEditingController _spotifyUsernameController;
  
  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
    });
  }
  
  SpotifyConnectStatus _spotifyConnectStatus;

  String _userId;

  @override
  initState() {
    initialTimer();

    _spotifyConnectStatus = SpotifyConnectStatus.disconnected;

    final _user = _auth.currentUser;
    if (_user != null)
      _userId = _user.uid;

    _spotifyUsernameController = new TextEditingController();

    super.initState();
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
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              width: SizeConfig.widthMultiplier * 100,
              height: SizeConfig.heightMultiplier * 100,
              child: Stack(
                children: <Widget>[
                  // --- Animate top circles
                  // AccentColor Circle
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    top: startAnimation ? SizeConfig.heightMultiplier * -4 : SizeConfig.heightMultiplier * -8,
                    left: startAnimation ? SizeConfig.widthMultiplier * -6 : SizeConfig.widthMultiplier * -35,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 34,
                      color: ThemeProvider.themeOf(context).data.accentColor,
                      shadowOffset: Offset(2, 4),
                      shadowBlurRadius: 6,
                      notFilled: false,
                    ),
                  ),
                  // Green Circle Frame
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    left: startAnimation ? SizeConfig.widthMultiplier * -2 : SizeConfig.widthMultiplier * -40,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 32,
                      color: const Color(0xff1db954),
                      notFilled: true,
                    ),
                  ),
                  // Green Circle
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    top: startAnimation ? SizeConfig.heightMultiplier * -6 : SizeConfig.heightMultiplier * -35,
                    left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * 20,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 38,
                      color: const Color(0xff1db954),
                      shadowOffset: Offset(-2, 3),
                      shadowBlurRadius: 6,
                      notFilled: false,
                    ),
                  ),
                  // AccentColor Circle Frame
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    top: startAnimation ? SizeConfig.heightMultiplier * -2 : SizeConfig.heightMultiplier * -40,
                    left: startAnimation ? SizeConfig.widthMultiplier * 16 : SizeConfig.widthMultiplier * 40,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 36,
                      color: ThemeProvider.themeOf(context).data.accentColor,
                      notFilled: true,
                    ),
                  ),

                  // --- Animated bottom circles
                  // AccentColor Circle Frame
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    bottom: startAnimation ? SizeConfig.heightMultiplier * -8 : SizeConfig.heightMultiplier * -40,
                    right: startAnimation ? SizeConfig.widthMultiplier * -8 : SizeConfig.widthMultiplier * 6,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 58,
                      color: ThemeProvider.themeOf(context).data.accentColor,
                      notFilled: true,
                    ),
                  ),
                  // Green Circle Frame
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    bottom: startAnimation ? SizeConfig.heightMultiplier * 2 : SizeConfig.heightMultiplier * 15,
                    right: startAnimation ? SizeConfig.widthMultiplier * -12 : SizeConfig.widthMultiplier * -50,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 38,
                      color: const Color(0xff1db954),
                      notFilled: true,
                    ),
                  ),
                  // Green Circle
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    bottom: startAnimation ? SizeConfig.heightMultiplier * -8 : SizeConfig.heightMultiplier * -40,
                    right: startAnimation ? SizeConfig.widthMultiplier * -4 : SizeConfig.widthMultiplier * -20,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 40,
                      color: const Color(0xff1db954),
                      shadowOffset: Offset(-3, 4),
                      shadowBlurRadius: 6,
                      notFilled: false,
                    ),
                  ),
                  // AccentColor Circle
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    bottom: startAnimation ? SizeConfig.heightMultiplier * -2 : SizeConfig.heightMultiplier * 1,
                    right: startAnimation ? SizeConfig.widthMultiplier * -16 : SizeConfig.widthMultiplier * -40,
                    curve: Curves.ease,
                    child: Circle(
                      diameter: SizeConfig.widthMultiplier * 36,
                      color: ThemeProvider.themeOf(context).data.accentColor,
                      shadowOffset: Offset(-3, 4),
                      shadowBlurRadius: 6,
                      notFilled: false,
                    ),
                  ),
                  
                  // Text Header
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
                          TextSpan(text: 'You must authorize\n',),
                          TextSpan(
                            text: 'AutoSpotify',
                            style: TextStyle(
                              color: ThemeProvider.themeOf(context).data.accentColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(text: ' to connect\nto your ',),
                          TextSpan(
                            text: 'Spotify',
                            style: TextStyle(
                              color: const Color(0xff1db954),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(text: ' account',),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: const Color(0xff1db954),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Spotify Widget
                  Positioned(
                    right: SizeConfig.widthMultiplier * 10,
                    child: Container(
                      height: SizeConfig.heightMultiplier * 100,
                      width: SizeConfig.widthMultiplier * 80,
                      alignment: Alignment.center,
                      child: Center(
                        child: SpotifyWidget(
                          connectStatus: _spotifyConnectStatus,
                          isIntroduction: true,
                          textFieldController: _spotifyUsernameController,
                          onConnectButtonPressed: () async {
                            if (_spotifyConnectStatus == SpotifyConnectStatus.disconnected) {
                              setState(() {
                                _spotifyConnectStatus = SpotifyConnectStatus.connecting;                                
                              });
                            }
                            else {
                              return;
                            }
                            
                            await SpotifyUtils().connect(context).then((SpotifyApi spotify) async {
                              SpotifyApiCredentials _spotifyCredentials = await spotify.getCredentials();
                              await FirestoreHelper().saveSpotifyCredentials(_spotifyCredentials, _userId).then((success) {
                                if (!success) {
                                  CustomSnackbar.show(context, 'Failed to save the credentials');
                                }
                              });
                              
                              final User user = await SpotifyUtils().getUser(spotify);

                              await SpotifyUtils().createPlaylist(context, spotify, _userId);

                              setState(() {
                                _spotifyUsernameController.text = 'Hello, ${user.displayName}';

                                _spotifyConnectStatus = SpotifyConnectStatus.connected;
                              });
                            })
                            .catchError((error) {
                              print('ERROR $error');
                              CustomSnackbar.show(
                                context,
                                'Oops! Something went wrong. Please try again.',
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  // Button 'Next
                  AnimatedPositioned(
                    duration: Duration(seconds: 1,),
                    bottom: SizeConfig.heightMultiplier * 20,
                    left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * -100,
                    curve: Curves.ease,
                    child: CustomButton(
                      label: 'Next',
                      onPressed: () {
                        if (_spotifyConnectStatus == SpotifyConnectStatus.connected) {
                          // Open next introduction page (package:autospotify/ui/introduction/introduction_yt.dart)
                          ButtonPressedHandler().pushAndReplaceToPage(context, YouTubeIntroductionPage());
                        }
                        else {
                          CustomSnackbar.show(
                            context,
                            'Please connect your Spotify profile with AutoSpotify before move on',
                          );
                        }
                      },
                    ),
                  ),

                  // Page Number
                  PageIndicator(
                    currentPage: 3,
                    maxPages: 4,
                  ),

                  // Back Button
                  Positioned(
                    top: SizeConfig.heightMultiplier * 3.160806006,
                    left: SizeConfig.widthMultiplier * 0,
                    child: CustomBackButton(
                      onPressed: () => {
                        // Open prevoiuse indroduction page (package:autospotify/ui/introduction/choose_theme_page.dart)
                        Navigator.of(context).pushReplacement(
                          PageTransition(child: CreateAccountPage(), type: PageTransitionType.fade)
                        )
                      },
                    ),
                  ),

                  NoNetworkConnection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}