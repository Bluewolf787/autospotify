import 'package:autospotify_design/ui/home/home_page.dart';
import 'package:autospotify_design/utils/size_config.dart';
import 'package:autospotify_design/utils/utils.dart';
import 'package:autospotify_design/widgets/button.dart';
import 'package:autospotify_design/widgets/circles.dart';
import 'package:autospotify_design/widgets/introduction_page_indicator.dart';
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
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => Utils.onBackButtonExit(context), 
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: Container(
          width: SizeConfig.widthMultiplier * 100,
          height: SizeConfig.heightMultiplier * 100,
          child: Stack(
            children: <Widget>[

              // Circle frame 1
              Positioned(
                top: SizeConfig.heightMultiplier * -2,
                right: SizeConfig.widthMultiplier * -14,
                child: Circle(
                  diameter: 194,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
              ),

              // Circle frame 2
              Positioned(
                top: SizeConfig.heightMultiplier * -11,
                right: SizeConfig.widthMultiplier * -6,
                child: Circle(
                  diameter: 210,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
              ),

              // Circle frame 3
              Positioned(
                top: SizeConfig.heightMultiplier * -5,
                right: SizeConfig.widthMultiplier * -33,
                child: Circle(
                  diameter: 296,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
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
                  ),
                  textAlign: TextAlign.left,
                ),
              ),


              // Theme Selection
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[  
                    // Light Theme selection
                    FlatButton.icon(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      onPressed: () => ThemeProvider.controllerOf(context).setTheme('light_theme'),
                      label: Text(
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
                      icon: Icon(
                        ThemeProvider.themeOf(context).id.toString() == 'light_theme' ? Icons.done : Icons.wb_sunny,
                        color: ThemeProvider.themeOf(context).id.toString() == 'light_theme' ? Colors.grey : Colors.yellow,
                      ),
                    ),
                    
                    // Dark Theme selection
                    FlatButton.icon(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      onPressed: () => ThemeProvider.controllerOf(context).setTheme('dark_theme'),
                      label: Text(
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
                      icon: Icon(
                        ThemeProvider.themeOf(context).id.toString() == 'dark_theme' ? Icons.done : Icons.nightlight_round,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Button 'Next'
              CustomButton(
                label: 'Next',
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                    PageTransition(child: HomePage(), type: PageTransitionType.rightToLeft)
                  )
                },
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