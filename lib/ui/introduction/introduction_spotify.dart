import 'package:autospotify/ui/introduction/choose_theme_page.dart';
import 'package:autospotify/ui/introduction/introduction_yt.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/back_button_handle.dart';
import 'package:autospotify/widgets/back_button.dart';
import 'package:autospotify/widgets/button.dart';
import 'package:autospotify/widgets/circles.dart';
import 'package:autospotify/widgets/introduction_page_indicator.dart';
import 'package:autospotify/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

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
  
  @override
  initState() {
    initialTimer();
    super.initState();
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
                  right: startAnimation ? SizeConfig.widthMultiplier * -4 : SizeConfig.widthMultiplier * 6,
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
                  left: startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -60,
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
                        TextSpan(text: 'Provide us your\n',),
                        TextSpan(
                          text: 'Spotify',
                          style: TextStyle(
                            color: const Color(0xff1db954),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: ' username',),
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

                // Input
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  right: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpotifyUsernameInputField(
                          controller: _spotifyUsernameController,
                          onEditingComplete: null,
                        ),
                      ],
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
                    onPressed: () => {
                      // Open next introduction page (package:autospotify/ui/introduction/introduction_yt.dart)
                      Navigator.of(context).pushReplacement(
                        PageTransition(child: YouTubeIntroductionPage(), type: PageTransitionType.fade)
                      ),
                    },
                  ),
                ),

                // Page Number
                PageIndicator(
                  currentPage: 2,
                  maxPages: 3,
                ),

                // Back Button
                Positioned(
                  top: SizeConfig.heightMultiplier * 3.160806006,
                  left: SizeConfig.widthMultiplier * 0,
                  child: CustomBackButton(
                    onPressed: () => {
                      // Open prevoiuse indroduction page (package:autospotify/ui/introduction/choose_theme_page.dart)
                      Navigator.of(context).pushReplacement(
                        PageTransition(child: ChooseThemePage(), type: PageTransitionType.fade)
                      )
                    },
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