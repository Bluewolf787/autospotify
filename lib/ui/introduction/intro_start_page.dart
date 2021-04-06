import 'package:autospotify/ui/introduction/choose_theme_page.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/widgets/buttons/button.dart';
import 'package:autospotify/widgets/layout/circles.dart';
import 'package:autospotify/widgets/layout/lines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
  
  @override
  initState() {
    initialTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                diameter: 222,
                color: Colors.blue,
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
                diameter: 163,
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
                diameter: 372,
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
                diameter: 288,
                color: Colors.blue,
                shadowOffset: Offset(5, -3),
                shadowBlurRadius: 6,
                notFilled: false,
              ),
            ),

            // Top Lines
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: startAnimation ? SizeConfig.heightMultiplier * 20 : SizeConfig.heightMultiplier * 20,
              left: startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
              curve: Curves.ease,
              child: Lines(positionTop: true,),
            ),

            // Header Text
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: startAnimation ? SizeConfig.heightMultiplier * 22 : SizeConfig.heightMultiplier * 22,
              left: startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -90,
              curve: Curves.ease,
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff000000),
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(text: 'Before you can use\n',),
                    TextSpan(
                      text: 'AutoSpotify ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(text: 'to automatically\ngenerate '),
                    TextSpan(
                      text: 'Spotify Playlists',
                      style: TextStyle(
                        color: const Color(0xff1db954),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(text: ',\nyou need to do some\nsteps first'),
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Bottom Lines
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              top: startAnimation ? SizeConfig.heightMultiplier * 48 : SizeConfig.heightMultiplier * 48,
              right: startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
              curve: Curves.ease,
              child: Lines(positionTop: false,),
            ),

            // Button 'Get Started' > Opens theme choose page
            AnimatedPositioned(
              duration: Duration(seconds: 1,),
              bottom: SizeConfig.heightMultiplier * 20,
              left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * -100,
              curve: Curves.ease,
              child: CustomButton(
                label: 'Go',
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                    PageTransition(child: ChooseThemePage(), type: PageTransitionType.fade)
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}