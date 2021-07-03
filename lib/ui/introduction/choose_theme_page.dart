import 'package:autospotify/l10n/app_localizations.dart';
import 'package:autospotify/ui/introduction/intro_start_page.dart';
import 'package:autospotify/ui/introduction/introduction_spotify.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/widgets/buttons/back_button.dart';
import 'package:autospotify/widgets/buttons/buttons.dart';
import 'package:autospotify/widgets/layout/circles.dart';
import 'package:autospotify/widgets/layout/introduction_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

class ChooseThemePage extends StatefulWidget {
  @override
  _ChooseThemePageState createState() => _ChooseThemePageState();
}

class _ChooseThemePageState extends State<ChooseThemePage> {

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
      onWillPop: () => ButtonPressedHandler().onBackButtonExit(context), 
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: Container(
          width: SizeConfig.widthMultiplier * 100,
          height: SizeConfig.heightMultiplier * 100,
          child: Stack(
            children: <Widget>[

              // Circle frame 1
              AnimatedPositioned(
                duration: Duration(seconds: 1,),
                top: startAnimation ? SizeConfig.heightMultiplier * -2 : SizeConfig.heightMultiplier * -20,
                right: startAnimation ? SizeConfig.widthMultiplier * -14 : SizeConfig.widthMultiplier * -55,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier * 52,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
              ),

              // Circle frame 2
              AnimatedPositioned(
                duration: Duration(seconds: 1,),
                top: startAnimation ? SizeConfig.heightMultiplier * -11 : SizeConfig.heightMultiplier * -40,
                right: startAnimation ? SizeConfig.widthMultiplier * -6 : SizeConfig.widthMultiplier * 10,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier * 56,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
              ),

              // Circle frame 3
              AnimatedPositioned(
                duration: Duration(seconds: 1,),
                top: startAnimation ? SizeConfig.heightMultiplier * -5 : SizeConfig.heightMultiplier * 10,
                right: startAnimation ? SizeConfig.widthMultiplier * -33 : SizeConfig.widthMultiplier * -120,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier * 81,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
              ),


              // Header Text
              AnimatedPositioned(
                duration: Duration(seconds: 1,),
                top: startAnimation ? SizeConfig.heightMultiplier * 22 : SizeConfig.heightMultiplier * 22,
                left: startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -90,
                curve: Curves.ease,
                child: Container(
                  width: SizeConfig.widthMultiplier * 80,
                  height: SizeConfig.heightMultiplier * 10,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.topLeft,
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
                          TextSpan(text: AppLocalizations.of(context).chooseThemeSpan1,),
                          TextSpan(
                            text: AppLocalizations.of(context).chooseThemeSpan2,
                            style: TextStyle(
                              color: ThemeProvider.themeOf(context).data.accentColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(text: AppLocalizations.of(context).chooseThemeSpanFr,),
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
                ),
              ),


              // Theme Selection
              AnimatedPositioned(
                duration: Duration(seconds: 1,),
                left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * 200,
                curve: Curves.ease,
                child: Container(
                  height: SizeConfig.heightMultiplier * 100,
                  width: SizeConfig.widthMultiplier * 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  
                      // Light Theme selection
                      TextButton.icon(
                        onPressed: () => ButtonPressedHandler().changeThemeButton(context),
                        label: Text(
                          AppLocalizations.of(context).btnLight,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        icon: Icon(
                          ThemeProvider.themeOf(context).id.toString() == 'light_theme' ? Icons.done : Icons.wb_sunny,
                          color: ThemeProvider.themeOf(context).id.toString() == 'light_theme' ? Colors.grey : Colors.yellow,
                        ),
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith((states) {
                            return Colors.transparent;
                          }),
                        ),
                      ),
                      
                      // Dark Theme selection
                      TextButton.icon(
                        onPressed: () => ButtonPressedHandler().changeThemeButton(context),
                        label: Text(
                          AppLocalizations.of(context).btnDark,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        icon: Icon(
                          ThemeProvider.themeOf(context).id.toString() == 'dark_theme' ? Icons.done : Icons.nightlight_round,
                          color: Colors.grey,
                        ),
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith((states) {
                            return Colors.transparent;
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Button 'Next'
              AnimatedPositioned(
                duration: Duration(seconds: 1,),
                bottom: SizeConfig.heightMultiplier * 20,
                left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * -100,
                curve: Curves.ease,
                child: CustomButton(
                  label: AppLocalizations.of(context).btnNext,
                  onPressed: () => {
                    // Open next introduction page (package:autospotify/ui/introduction/introduction_spotify.dart)
                    Navigator.of(context).pushReplacement(
                      PageTransition(child: SpotifyIntroductionPage(), type: PageTransitionType.fade)
                    ),
                  },
                ),
              ),

              // Back Button
              Positioned(
                top: SizeConfig.heightMultiplier * 3.160806006,
                left: SizeConfig.widthMultiplier * 0,
                child: CustomBackButton(
                  onPressed: () => {
                    // Open prevoiuse indroduction page (package:autospotify/ui/introduction/choose_theme_page.dart)
                    Navigator.of(context).pushReplacement(
                      PageTransition(child: IntroStartPage(), type: PageTransitionType.fade)
                    )
                  },
                ),
              ),

              // Page Number
              PageIndicator(
                currentPage: 1,
                maxPages: 3,
              ),
            ],
          ),
        ),  
      ),
    );
  }
}