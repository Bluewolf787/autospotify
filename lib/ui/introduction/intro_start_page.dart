import 'package:autospotify/ui/introduction/choose_theme_page.dart';
import 'package:autospotify/utils/db/shared_prefs_helper.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/widgets/buttons/button.dart';
import 'package:autospotify/widgets/input/language_dropdown.dart';
import 'package:autospotify/widgets/layout/circles.dart';
import 'package:autospotify/widgets/layout/lines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

class IntroStartPage extends StatefulWidget {
  @override
  _IntroStartPageState createState() => _IntroStartPageState();
}

class _IntroStartPageState extends State<IntroStartPage> {

  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
    });
  }
  
  String _currentLanguage;
  Future<void> _getCurrentLanguage() async {
    SharedPreferencesHelper().getCurrentLanguage().then((language) {
      setState(() {
        _currentLanguage = language;        
      });
    });
  }

  @override
  initState() {
    super.initState();
    initialTimer();
    _getCurrentLanguage();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
      body: Container(
        width: SizeConfig.widthMultiplier * 100,
        height: SizeConfig.heightMultiplier * 100,
        child: Stack(
          children: <Widget>[
            // Blue circle frame
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: startAnimation ? SizeConfig.heightMultiplier * -6.5 : SizeConfig.heightMultiplier * -25,
              right: startAnimation ? SizeConfig.widthMultiplier * -38 : SizeConfig.widthMultiplier * -60,
              curve: Curves.ease,
              child: Circle(
                diameter: SizeConfig.widthMultiplier * 62,
                color: ThemeProvider.themeOf(context).data.accentColor,
                notFilled: true,
              ),
            ),
            

            // Green circle frame
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: startAnimation ? SizeConfig.heightMultiplier * -6 : SizeConfig.heightMultiplier * -35,
              right: startAnimation ? SizeConfig.widthMultiplier * -3.5 : SizeConfig.widthMultiplier * 10,
              curve: Curves.ease,
              child: Circle(
                diameter: SizeConfig.widthMultiplier * 45,
                color: const Color(0xff1db954),
                notFilled: true,
              ),
            ),
            

            // Green circle
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              bottom: startAnimation ? SizeConfig.heightMultiplier * -30 : SizeConfig.heightMultiplier * 10,
              left: startAnimation ? SizeConfig.widthMultiplier * -54 : SizeConfig.widthMultiplier * -120,
              curve: Curves.ease,
              child: Circle(
                diameter: SizeConfig.widthMultiplier * 102,
                color: const Color(0xff1db954),
                shadowOffset: Offset(5, -3),
                shadowBlurRadius: 6,
                notFilled: false,
              ),
            ),
            
            // Blue cicle
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              bottom: startAnimation ? SizeConfig.heightMultiplier * -30 : SizeConfig.heightMultiplier * -70,
              left: startAnimation ? SizeConfig.widthMultiplier * -10 : SizeConfig.widthMultiplier * -30,
              curve: Curves.ease,
              child: Circle(
                diameter: SizeConfig.widthMultiplier * 78,
                color: ThemeProvider.themeOf(context).data.accentColor,
                shadowOffset: Offset(5, -3),
                shadowBlurRadius: 6,
                notFilled: false,
              ),
            ),

            // Top Lines
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: startAnimation ? SizeConfig.heightMultiplier * 20 : SizeConfig.heightMultiplier * 20,
              left: startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -140,
              curve: Curves.ease,
              child: Lines(positionTop: true,),
            ),

            // Header Text
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: startAnimation ? SizeConfig.heightMultiplier * 22 : SizeConfig.heightMultiplier * 22,
              left: startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -90,
              curve: Curves.ease,
              child: Container(
                width: SizeConfig.widthMultiplier * 80,
                height: SizeConfig.heightMultiplier * 23,
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
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
                        TextSpan(text: 'Before you can use\n',),
                        TextSpan(
                          text: 'AutoSpotify ',
                          style: TextStyle(
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: 'to automatically\ngenerate '),
                        TextSpan(
                          text: 'Spotify ',
                          style: TextStyle(
                            color: const Color(0xff1db954),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: 'playlists,\nyou need to do some\nsteps first'),
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
              ),
            ),

            // Bottom Lines
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: SizeConfig.heightMultiplier * 47.5,
              right: startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -140,
              curve: Curves.ease,
              child: Lines(positionTop: false,),
            ),


            // Button Go > Opens theme choose page
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              bottom: SizeConfig.heightMultiplier * 20,
              left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * -100,
              curve: Curves.ease,
              child: CustomButton(
                label: 'Go',
                onPressed: () async {
                  await FirestoreHelper().addUser();
                  Navigator.of(context).pushReplacement(
                    PageTransition(child: ChooseThemePage(), type: PageTransitionType.fade)
                  );
                },
              ),
            ),

            // Language Selection
            Positioned(
              bottom: SizeConfig.heightMultiplier * 1,
              right: SizeConfig.widthMultiplier * 4,
              child: LanguageSelector(
                value: _currentLanguage,
                onChanged: (String newLanguage) {
                  setState(() {
                    _currentLanguage = newLanguage;                  
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}