import 'package:autospotify_design/utils/size_config.dart';
import 'package:autospotify_design/utils/utils.dart';
import 'package:autospotify_design/widgets/button.dart';
import 'package:autospotify_design/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController spotifyUsernameController;
  TextEditingController ytPlaylistUrlController;

  @override
  void initState() {
    super.initState();
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
        //resizeToAvoidBottomInset: false,
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            width: SizeConfig.widthMultiplier * 100,
            height: SizeConfig.heightMultiplier * 100,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: SizeConfig.heightMultiplier * 3.160806006,
                  right: SizeConfig.widthMultiplier * 6.111535523,
                  // Theme Change Button
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),        
                        icon: ThemeProvider.themeOf(context).id == 'light_theme' ? Icon(Icons.wb_sunny) : Icon(Icons.nightlight_round),
                        color: ThemeProvider.themeOf(context).id == 'light_theme' ? Colors.yellow : Colors.grey,
                        tooltip: ThemeProvider.themeOf(context).id == 'light_theme' ? 'Activate Dark Theme' : 'Activate Light Theme',
                        onPressed: () => ThemeProvider.controllerOf(context).nextTheme(),
                      ),

                      Text(
                        '|',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),

                      // Account Button
                      FlatButton.icon(
                        onPressed: () => print('Hello Wolrd'), // TODO: Open Login Page or Account Fullscreen Dialog
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        label: Text(
                          'Account', // TODO: Says 'Login' or 'Account'
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),              
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                        ),          
                      ),
                    ],
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
                        TextSpan(text: 'Add Songs from\n',),
                        TextSpan(
                          text: 'YouTube',
                          style: TextStyle(
                            color: const Color(0xffff0000),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: ' playlists\nautomatically to your\n',),
                        TextSpan(
                          text: 'Spotify',
                          style: TextStyle(
                            color: const Color(0xff1db954),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: ' playlist',),
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

                // Lines
                Positioned(
                  top: SizeConfig.heightMultiplier * 42,
                  right: SizeConfig.widthMultiplier * 8,
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
                            indent: 60.5,
                            endIndent: 145.5,
                            color: const Color(0xff1db954),
                            thickness: 4,
                          ),
                        ),
                        
                        // Red Line
                        Align(
                          alignment: Alignment(92.0, 1.0),
                          child: Divider(
                            height: 0.0,
                            indent: 12.5,
                            endIndent: 195.1,
                            color: const Color(0xffff0000),
                            thickness: 4,
                          ),
                        ),
                          
                        // AccentColor line
                        Align(
                          alignment: Alignment(164.0, 1.0),
                          child: Divider(
                            height: 0.0,
                            indent: 110.5,
                            endIndent: 20.5,
                            color: ThemeProvider.themeOf(context).data.accentColor,
                            thickness: 4,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),

                // Main Content
                Center(
                  child: Container(
                    //color: Colors.pink,
                    padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                    height: SizeConfig.heightMultiplier * 40,
                    width: SizeConfig.widthMultiplier * 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Spotify Username Textfield
                        SpotifyUsernameInputField(
                          controller: spotifyUsernameController,
                          onEditingComplete: null, // TODO: Test connection when changed
                        ),

                        SizedBox(height: SizeConfig.heightMultiplier * 3.0,),

                        // Textfield 'playlistUrl'
                        YtPlaylistUrlInputField(
                          controller: ytPlaylistUrlController,
                          onEditingComplete: null, // TODO: Check connection to yt playlist when edited
                        ),
                      ],
                    ),
                  ),
                ),

                // Sync Button
                CustomButton(
                  label: 'Sync',
                  onPressed: () => {
                    null // TODO: Sync Playlists
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}