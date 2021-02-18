import 'package:autospotify_design/ui/introduction/choose_theme_page.dart';
import 'package:autospotify_design/utils/size_config.dart';
import 'package:autospotify_design/widgets/button.dart';
import 'package:autospotify_design/widgets/circles.dart';
import 'package:autospotify_design/widgets/lines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class IntroStartPage extends StatefulWidget {
  @override
  _IntroStartPageState createState() => _IntroStartPageState();
}

class _IntroStartPageState extends State<IntroStartPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        width: SizeConfig.widthMultiplier * 100,
        height: SizeConfig.heightMultiplier * 100,
        child: Stack(
          children: <Widget>[
            // Blue circle frame
            Positioned(
              top: SizeConfig.heightMultiplier * -6.5,
              right: SizeConfig.widthMultiplier * -38,
              child: Circle(
                diameter: 222,
                color: Colors.blue,
                notFilled: true,
              ),
            ),
            

            // Green circle frame
            Positioned(
              top: SizeConfig.heightMultiplier * -6,
              right: SizeConfig.widthMultiplier * -3.5,
              child: Circle(
                diameter: 163,
                color: const Color(0xff1db954),
                notFilled: true,
              ),
            ),
            

            // Green circle
            Positioned(
              bottom: SizeConfig.heightMultiplier * -30,
              left: SizeConfig.widthMultiplier * -54,
              child: Circle(
                diameter: 372,
                color: const Color(0xff1db954),
                notFilled: false,
              ),
            ),
            
            // Blue cicle
            Positioned(
              bottom: SizeConfig.heightMultiplier * -30,
              left: SizeConfig.widthMultiplier * -10,
              child: Circle(
                diameter: 288,
                color: Colors.blue,
                notFilled: false,
              ),
            ),

            // Top Lines
            Positioned(
              top: SizeConfig.heightMultiplier * 20,
              left: SizeConfig.widthMultiplier * 2,
              child: Lines(positionTop: true,),
            ),

            // Header Text
            Positioned(
              top: SizeConfig.heightMultiplier * 22,
              left: SizeConfig.widthMultiplier * 8,
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
            Positioned(
              top: SizeConfig.heightMultiplier * 48,
              right: SizeConfig.widthMultiplier * 8,
              child: Lines(positionTop: false,),
            ),

            // Button 'Get Started' > Opens theme choose page
            CustomButton(
              label: 'Get Started',
              onPressed: () => {
                Navigator.of(context).pushReplacement(
                  PageTransition(child: ChooseThemePage(), type: PageTransitionType.rightToLeft)
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}