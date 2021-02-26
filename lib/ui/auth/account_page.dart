import 'package:autospotify/ui/home/home_page.dart';
import 'package:autospotify/ui/introduction/intro_start_page.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/utils.dart';
import 'package:autospotify/widgets/back_button.dart';
import 'package:autospotify/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  TextEditingController _emailContoller;

  var startAnimation = false;
  initalTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initalTimer();
    _emailContoller = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => Utils.onBackButtonExit(context),
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.widthMultiplier * 100,
            child: Stack(
              children: <Widget>[
                // Top Lines
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  top: startAnimation ? SizeConfig.heightMultiplier * 20 : SizeConfig.heightMultiplier * 20,
                  left: startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
                  curve: Curves.ease,
                  child: SizedBox(
                    width: 236.0,
                    height: 0.0,
                    child: Stack(
                      children: <Widget>[
                        // Blue line
                        Align(
                          alignment: Alignment(164.0, 1.0),
                          child: Divider(
                            height: 0.0,
                            indent: 22.5,
                            endIndent: 9.5,
                            color: Colors.blue,
                            thickness: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: SizeConfig.heightMultiplier * 22,
                  child: Container(
                    width: SizeConfig.widthMultiplier * 100,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1,),
                      opacity: startAnimation ? 1.0 : 0.0,
                      curve: Curves.linear,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.account_circle_rounded,
                              size: 124,
                              color: Colors.grey,
                            ),
                            Text(
                              'Your Account',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Lines
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  top: startAnimation ? SizeConfig.heightMultiplier * 48 : SizeConfig.heightMultiplier * 48,
                  right: startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
                  curve: Curves.ease,
                  child: SizedBox(
                    width: 236.0,
                    height: 0.0,
                    child: Stack(
                      children: <Widget>[
                        // Blue line
                        Align(
                          alignment: Alignment(164.0, 1.0),
                          child: Divider(
                            height: 0.0,
                            indent: 12.5,
                            endIndent: 20.5,
                            color: Colors.blue,
                            thickness: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Email Box
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 15),
                    alignment: Alignment.center,
                    child: Container(
                      child: CustomTextField(
                        controller: _emailContoller,
                        onEditingComplete: () => null,
                        obscureText: false,
                        labelText: 'E-Mail',
                        hintText: 'Your E-Mail Address',
                      ),
                    ),
                  ),
                ),

                // Change Password Button
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  right: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 35),
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: SizeConfig.heightMultiplier * 8,
                      width: SizeConfig.widthMultiplier * 80,
                      child: OutlineButton.icon(
                        icon: Icon(
                          Icons.vpn_key_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Change Password',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: ThemeProvider.themeOf(context).data.accentColor,
                          width: 2.0
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        onPressed: () => null,
                      ),
                    ),
                  ),
                ),

                AnimatedOpacity(
                  duration: Duration(seconds: 1,),
                  opacity: startAnimation ? 1.0 : 0.0,
                  curve: Curves.linear,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 47),
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey,
                      height: 1.0,
                      indent: 80,
                      endIndent: 20,
                    ),
                  ),
                ),

                // Show Intro again
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 57),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: SizeConfig.widthMultiplier * 80,
                      child: OutlineButton.icon(
                        icon: Icon(
                          Icons.book_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Start introduction',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: ThemeProvider.themeOf(context).data.accentColor,
                          width: 2.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(child: IntroStartPage(), type: PageTransitionType.fade)
                          )
                        },
                      ),
                    ),
                  ),
                ),

                // SignOut Button
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  right: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 72),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: SizeConfig.widthMultiplier * 80,
                      child: OutlineButton.icon(
                        icon: Icon(
                          Icons.logout,
                          size: 18,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Logout',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                          ),
                        ),
                        highlightColor: Colors.red,
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        onPressed: () => null,
                      ),
                    ),
                  ),
                ),

                // Delete Account Button 
                AnimatedPositioned(
                  duration: Duration(seconds: 1,),
                  left: startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                  curve: Curves.ease,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 100,
                    width: SizeConfig.widthMultiplier * 80,
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 87),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: SizeConfig.widthMultiplier * 80,
                      child: OutlineButton.icon(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ThemeProvider.themeOf(context).data.primaryColor,
                          ),
                        ),
                        highlightedBorderColor: Colors.red,
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        onPressed: () => null,
                      ),
                    ),
                  ),
                ),          

                // Back Button
                Positioned(
                  top: SizeConfig.heightMultiplier * 3.160806006,
                  left: SizeConfig.widthMultiplier * 0,
                  child: AnimatedOpacity(
                    duration: Duration(seconds: 1,),
                    opacity: startAnimation ? 1.0 : 0.0,
                    curve: Curves.linear,
                    child: CustomBackButton(
                      onPressed: () => {
                        // Open prevoiuse indroduction page (package:autospotify/ui/introduction/introduction_spotify.dart)
                        Navigator.of(context).pushReplacement(
                          PageTransition(child: HomePage(), type: PageTransitionType.fade)
                        ),
                      },
                    ),
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