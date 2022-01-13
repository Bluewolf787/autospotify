import 'package:autospotify/l10n/app_localizations.dart';
import 'package:autospotify/ui/home/home_page.dart';
import 'package:autospotify/ui/introduction/introduction_spotify.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/db/shared_prefs_helper.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/youtube/youtube_utils.dart';
import 'package:autospotify/widgets/buttons/back_button.dart';
import 'package:autospotify/widgets/buttons/buttons.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:autospotify/widgets/layout/circles.dart';
import 'package:autospotify/widgets/layout/introduction_page_indicator.dart';
import 'package:autospotify/widgets/input/textfields.dart';
import 'package:autospotify/widgets/layout/no_network_connection.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class YouTubeIntroductionPage extends StatefulWidget {
  @override
  _YouTubeIntroductionPageState createState() =>
      _YouTubeIntroductionPageState();
}

class _YouTubeIntroductionPageState extends State<YouTubeIntroductionPage> {
  late TextEditingController _ytPlaylistUrlController;

  var startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      startAnimation = true;
    });
  }

  @override
  initState() {
    super.initState();
    initialTimer();

    _ytPlaylistUrlController = new TextEditingController();
  }

  @override
  void dispose() {
    _ytPlaylistUrlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor:
          ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: SizeConfig.widthMultiplier! * 100,
          height: SizeConfig.heightMultiplier! * 100,
          child: Stack(
            children: <Widget>[
              // --- Animate top circles
              // Red Circle Frame
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                top: startAnimation
                    ? SizeConfig.heightMultiplier! * -8
                    : SizeConfig.heightMultiplier! * -30,
                right: startAnimation
                    ? SizeConfig.widthMultiplier! * -4
                    : SizeConfig.widthMultiplier! * 20,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier! * 48,
                  color: Color(0xffff0000),
                  notFilled: true,
                ),
              ),
              // AccentColor Circle Frame
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                top: startAnimation
                    ? SizeConfig.heightMultiplier! * -1
                    : SizeConfig.heightMultiplier! * 5,
                right: startAnimation
                    ? SizeConfig.widthMultiplier! * -10
                    : SizeConfig.widthMultiplier! * -50,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier! * 44,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
              ),
              // Red Circle
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                top: startAnimation
                    ? SizeConfig.heightMultiplier! * -0.5
                    : SizeConfig.heightMultiplier! * -10,
                right: startAnimation
                    ? SizeConfig.widthMultiplier! * -12
                    : SizeConfig.widthMultiplier! * -40,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier! * 36,
                  color: const Color(0xffff0000),
                  shadowOffset: Offset(-4, 3),
                  shadowBlurRadius: 6,
                  notFilled: false,
                ),
              ),

              // --- Animated bottom circles
              // Red Circle Frame
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                bottom: startAnimation
                    ? SizeConfig.heightMultiplier! * 0
                    : SizeConfig.heightMultiplier! * 15,
                left: startAnimation
                    ? SizeConfig.widthMultiplier! * -16
                    : SizeConfig.widthMultiplier! * -65,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier! * 60,
                  color: const Color(0xffff0000),
                  notFilled: true,
                ),
              ),
              // Red Circle
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                bottom: startAnimation
                    ? SizeConfig.heightMultiplier! * 0
                    : SizeConfig.heightMultiplier! * 5,
                left: startAnimation
                    ? SizeConfig.widthMultiplier! * -16
                    : SizeConfig.widthMultiplier! * -55,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier! * 44,
                  color: const Color(0xffff0000),
                  shadowOffset: Offset(3, -1),
                  shadowBlurRadius: 6,
                  notFilled: false,
                ),
              ),
              // AccentColor Circle Frame
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                bottom: startAnimation
                    ? SizeConfig.heightMultiplier! * -10
                    : SizeConfig.heightMultiplier! * -40,
                left: startAnimation
                    ? SizeConfig.widthMultiplier! * -2
                    : SizeConfig.widthMultiplier! * 5,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier! * 52,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  notFilled: true,
                ),
              ),
              // AccentColor Circle
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                bottom: startAnimation
                    ? SizeConfig.heightMultiplier! * -10
                    : SizeConfig.heightMultiplier! * -15,
                left: startAnimation
                    ? SizeConfig.widthMultiplier! * -2
                    : SizeConfig.widthMultiplier! * -40,
                curve: Curves.ease,
                child: Circle(
                  diameter: SizeConfig.widthMultiplier! * 40,
                  color: ThemeProvider.themeOf(context).data.accentColor,
                  shadowOffset: Offset(4, -2),
                  shadowBlurRadius: 6,
                  notFilled: false,
                ),
              ),

              // Text Header
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                top: startAnimation
                    ? SizeConfig.heightMultiplier! * 22
                    : SizeConfig.heightMultiplier! * 22,
                left: startAnimation
                    ? SizeConfig.widthMultiplier! * 8
                    : SizeConfig.widthMultiplier! * -80,
                curve: Curves.ease,
                child: Container(
                  width: SizeConfig.widthMultiplier! * 80,
                  height: SizeConfig.heightMultiplier! * 15,
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
                          color:
                              ThemeProvider.themeOf(context).data.primaryColor,
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.introYtSpan1,
                          ),
                          TextSpan(
                            text: 'YouTube',
                            style: TextStyle(
                              color: const Color(0xffff0000),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.introYtSpan2,
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: const Color(0xffff0000),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Input
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                right: startAnimation
                    ? SizeConfig.widthMultiplier! * 10
                    : SizeConfig.widthMultiplier! * -100,
                curve: Curves.ease,
                child: Container(
                  height: SizeConfig.heightMultiplier! * 100,
                  width: SizeConfig.widthMultiplier! * 80,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      YtPlaylistUrlInputField(
                        controller: _ytPlaylistUrlController,
                        suffixIconButton: IconButton(
                          icon: Icon(Icons.delete_outline_rounded),
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          color:
                              ThemeProvider.themeOf(context).data.primaryColor,
                          onPressed: () {
                            _ytPlaylistUrlController.clear();
                          },
                          tooltip: AppLocalizations.of(context)!.clearToolTip,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Button 'Next
              AnimatedPositioned(
                duration: Duration(
                  seconds: 1,
                ),
                bottom: SizeConfig.heightMultiplier! * 20,
                left: startAnimation
                    ? SizeConfig.widthMultiplier! * 0
                    : SizeConfig.widthMultiplier! * -100,
                curve: Curves.ease,
                child: CustomButton(
                  label: AppLocalizations.of(context)!.btnFinish,
                  onPressed: () async {
                    String? _userId = await SharedPreferencesHelper().getUuid();
                    await YouTubeUtils()
                        .getPlaylistId(context, _ytPlaylistUrlController.text)
                        .then((value) async {
                      if (value != null) {
                        await FirestoreHelper().saveYouTubePlaylistUrl(
                            _ytPlaylistUrlController.text, _userId);

                        await SharedPreferencesHelper().setIntroSeenBool();

                        // Open home page (package:autospotify/ui/home/home_page.dart)
                        ButtonPressedHandler()
                            .pushAndReplaceToPage(context, HomePage());
                      }
                    });
                  },
                ),
              ),

              // Page Number
              PageIndicator(
                currentPage: 3,
                maxPages: 3,
              ),

              // Back Button
              Positioned(
                top: SizeConfig.heightMultiplier! * 3.160806006,
                left: SizeConfig.widthMultiplier! * 0,
                child: CustomBackButton(
                  onPressed: () => {
                    // Open prevoiuse indroduction page (package:autospotify/ui/introduction/introduction_spotify.dart)
                    ButtonPressedHandler().pushAndReplaceToPage(
                        context, SpotifyIntroductionPage())
                  },
                ),
              ),

              NoNetworkConnection(),
            ],
          ),
        ),
      ),
    );
  }
}
