import 'package:autospotify_design/ui/choose_theme_page.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: <Widget>[

          // Blue circle frame
          Positioned(
            top: -30,
            right: -135,
            child: Container(
              width: 222,
              height: 222,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                border: Border.all(
                  width: 2.0,
                  color: const Color(0xff2196f3),
                ),
              ),
            ),
          ),

          // Green circle frame
          Positioned(
            top: -70,
            right: 20,
            child: Container(
              width: 163,
              height: 163,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                border: Border.all(
                  width: 2.0,
                  color: const Color(0xff1db954),
                ),
              ),
            ),
          ),

          // Green circle
          Positioned(
            bottom: -120,
            left: -180,
            child: Container(
              width: 372,
              height: 372,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xff1db954),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x40000000),
                    offset: Offset(5, -3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          
          // Blue cicle
          Positioned(
            bottom: -160,
            left: -30,
            child: Container(
              width: 288,
              height: 288,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xff2196f3),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x33000000),
                        offset: Offset(5, -4),
                        blurRadius: 6
                    )
                  ]
              ),
            ),
          ),

          // Top Lines
          Positioned(
            top: 155,
            left: 14,
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
                      indent: 152.5,
                      endIndent: 9.5,
                      color: const Color(0xff1db954),
                      thickness: 4,
                    ),
                  ),
                  // Blue line
                  Align(
                    alignment: Alignment(164.0, 1.0),
                    child: Divider(
                      height: 0.0,
                      indent: 22.5,
                      endIndent: 80.5,
                      color: const Color(0xff2196f3),
                      thickness: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Header Text
          Positioned(
            top: 165,
            left: 35,
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
                      color: const Color(0xff2196f3),
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
                      color: const Color(0xff2196f3),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              )
            ),
          ),

          // Bottom Lines
          Positioned(
            top: 350,
            left: 125,
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
                      indent: 12.5,
                      endIndent: 164.5,
                      color: const Color(0xff1db954),
                      thickness: 4,
                    ),
                  ),
                  // Blue line
                  Align(
                    alignment: Alignment(164.0, 1.0),
                    child: Divider(
                      height: 0.0,
                      indent: 82.5,
                      endIndent: 20.5,
                      color: const Color(0xff2196f3),
                      thickness: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Button 'Get Started' > Opens theme choose page
          Positioned(
            bottom: 150,
            left: 80,
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(45, 10, 45 , 10),
              onPressed: () => {
                Navigator.pushReplacement(
                  context, PageTransition(child: ChooseThemePage(), type: PageTransitionType.rightToLeft)
                  )
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: const Color(0xff2196f3)),
              ),
              color: const Color(0xff2196f3),
              textColor: Colors.white,
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 26.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}