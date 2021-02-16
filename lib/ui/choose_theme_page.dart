import 'package:autospotify_design/ui/home_page.dart';
import 'package:autospotify_design/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

class ChooseThemePage extends StatefulWidget {
  @override
  _ChooseThemePageState createState() => _ChooseThemePageState();
}

class _ChooseThemePageState extends State<ChooseThemePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.onBackButtonExit(context), 
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[

            // Circle frame 1
            Positioned(
              top: -20,
              right: -60,
              child: Container(
                width: 194,
                height: 194,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  border: Border.all(
                    width: 2.0,
                    color: ThemeProvider.themeOf(context).data.accentColor,
                  )
                ),
              ),
            ),

            // Circle frame 2
            Positioned(
              top: -90,
              right: -25,
              child: Container(
                width: 210,
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  border: Border.all(
                    width: 2.0,
                    color: ThemeProvider.themeOf(context).data.accentColor,
                  )
                ),
              ),
            ),

            // Circle frame 3
            Positioned(
              top: -40,
              right: -130,
              child: Container(
                width: 296,
                height: 296,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  border: Border.all(
                    width: 2.0,
                    color: ThemeProvider.themeOf(context).data.accentColor,
                  )
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
                    color: ThemeProvider.themeOf(context).data.primaryColor,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(text: 'Choose your favorite\n',),
                    TextSpan(
                      text: 'theme',
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
                )
              ),
            ),

            // Theme Selection
            Positioned(
              top: 340,
              left: 140,
              child: SizedBox(
                width: 80,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                
                    // Light Theme selection
                    FlatButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      onPressed: () => ThemeProvider.controllerOf(context).setTheme('light_theme'),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            ThemeProvider.themeOf(context).id.toString() == 'light_theme' ? Icons.done : Icons.wb_sunny,
                            color: ThemeProvider.themeOf(context).id.toString() == 'light_theme' ? Colors.grey : Colors.yellow,
                          ),

                          Spacer(),

                          Text(
                            'Light',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: ThemeProvider.themeOf(context).data.primaryColor,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    
                    // Dark Theme selection
                    FlatButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      onPressed: () => ThemeProvider.controllerOf(context).setTheme('dark_theme'),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            ThemeProvider.themeOf(context).id.toString() == 'dark_theme' ? Icons.done : Icons.nightlight_round,
                            color: Colors.grey,
                          ),

                          Spacer(),

                          Text(
                            'Dark',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: ThemeProvider.themeOf(context).data.primaryColor,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            // Button 'Next'
            Positioned(
              bottom: 150,
              left: 120,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(45, 10, 45 , 10),
                onPressed: () => {
                  Navigator.pushReplacement(
                    context, PageTransition(child: HomePage(), type: PageTransitionType.rightToLeft)
                  )
                  //showDialog(context: context, builder: (_) => ThemeDialog())
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: ThemeProvider.themeOf(context).data.accentColor,
                textColor: Colors.white,
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.5, 1.5),
                        blurRadius: 3,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
/*
            // Page Number
            Positioned(
              child: null
            ),
*/

          ],
        ),
      ),
    );
  }
}