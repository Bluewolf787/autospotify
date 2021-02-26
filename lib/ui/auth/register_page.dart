import 'package:autospotify/ui/auth/login_page.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/widgets/back_button.dart';
import 'package:autospotify/widgets/button.dart';
import 'package:autospotify/widgets/signin_button.dart';
import 'package:autospotify/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;

  Duration _duration;
  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initialTimer();
    _duration = new Duration(seconds: 1);

    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: SizeConfig.heightMultiplier * 100,
          width: SizeConfig.widthMultiplier * 100,
          child: Stack(
            children: <Widget>[
              // Header Text
              AnimatedPositioned(
                duration: _duration,
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
                      TextSpan(text: 'Register a new ',),
                      TextSpan(
                        text: 'Account',
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

              // Register with socials
              Positioned(
                top: SizeConfig.heightMultiplier * 32,
                child: AnimatedOpacity(
                  duration: _duration,
                  opacity: startAnimation ? 1.0 : 0.0,
                  curve: Curves.linear,
                  child: Container(
                    width: SizeConfig.widthMultiplier * 100,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login with:',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                            height: 1.3,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SignInButton(
                              onPressed: () => null,
                              assetImage: 'assets/google_logo.png',
                              label: 'Google',
                              color: Colors.blue,
                            ),
                            Padding(padding: EdgeInsets.only(left: 20)),
                            SignInButton(
                              onPressed: () => null,
                              assetImage: 'assets/github_logo.png',
                              label: 'GitHub',
                              color: ThemeProvider.themeOf(context).data.primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // E-Mail Input
              AnimatedPositioned(
                duration: _duration,
                left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * 100,
                curve: Curves.ease,
                child: Container(
                  height: SizeConfig.heightMultiplier * 100,
                  width: SizeConfig.widthMultiplier * 80,
                  alignment: Alignment.center,
                  child: CustomTextField(
                    controller: _emailInputController,
                    onEditingComplete: () => null,
                    obscureText: false,
                    hintText: 'Enter your E-Mail address',
                    labelText: 'E-Mail Address',
                  ),
                ),
              ),

              // Password Input
              AnimatedPositioned(
                duration: _duration,
                left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                curve: Curves.ease,
                child: Container(
                  height: SizeConfig.heightMultiplier * 100,
                  width: SizeConfig.widthMultiplier * 80,
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 22),
                  alignment: Alignment.center,
                  child: CustomTextField(
                    controller: _passwordInputController,
                    onEditingComplete: () => null,
                    obscureText: true,
                    hintText: 'Enter a password',
                    labelText: 'Password',
                  ),
                ),
              ),

              // Register Button
              AnimatedPositioned(
                duration: _duration,
                bottom: SizeConfig.heightMultiplier * 20,
                left: startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * 100,
                curve: Curves.ease,
                child: CustomButton(
                  label: 'Register',
                  onPressed: () => {
                    null
                  },
                ),
              ),

              // Go to LogIn button
              Positioned(
                bottom: SizeConfig.heightMultiplier * 10,
                child: AnimatedOpacity(
                  duration: _duration,
                  opacity: startAnimation ? 1.0 : 0.0,
                  curve: Curves.linear,
                  child: Container(
                    width: SizeConfig.widthMultiplier * 100,
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return LoginPage();
                            },
                            fullscreenDialog: true,
                          )
                        )
                      },
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Already have one? Login',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ThemeProvider.themeOf(context).data.primaryColor,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Back Button
              Positioned(
                top: SizeConfig.heightMultiplier * 3.160806006,
                left: SizeConfig.widthMultiplier * 0,
                child: AnimatedOpacity(
                  duration: _duration,
                  opacity: startAnimation ? 1.0 : 0.0,
                  curve: Curves.linear,
                  child: CustomBackButton(
                    onPressed: () => {
                      Navigator.of(context).pop()
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}