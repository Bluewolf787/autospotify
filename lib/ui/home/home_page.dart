import 'dart:async';

import 'package:autospotify/ui/auth/account_page.dart';
import 'package:autospotify/ui/auth/login_page.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/db/shared_prefs_helper.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/spotify/spotify_connect_status.dart';
import 'package:autospotify/utils/spotify/spotify_utils.dart';
import 'package:autospotify/utils/sync_status.dart';
import 'package:autospotify/utils/youtube/youtube_utils.dart';
import 'package:autospotify/widgets/buttons/button.dart';
import 'package:autospotify/widgets/dialogs/dialogs.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:autospotify/widgets/input/textfields.dart';
import 'package:autospotify/widgets/layout/no_network_connection.dart';
import 'package:autospotify/widgets/spotify_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:theme_provider/theme_provider.dart';

final Firebase.FirebaseAuth _auth = Firebase.FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _spotifyUsernameController;
  TextEditingController _ytPlaylistUrlController;

  var _startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _startAnimation = true;
    });
  }

  SyncStatus _syncStatus;

  // User variables //
  SharedPreferencesHelper _sharedPreferencesHelper;
  Firebase.User _user;
  var _isUserLoggedIn = false;
  String _userId;
  String _username;
  String _userEmail;
  String _userAvatarUrl;

  var _avatarLoadError = false;

  String _provider;
  var _isGoogleUser = false;

  // Get the data of current user
  Future<void> _getUserData() async {
    if (!mounted) return;

    _user = _auth.currentUser;
    if (_user != null) {
      setState(() {
        _isUserLoggedIn = true;
        _userId = _user.uid;
        _username = _user.displayName;
        _userEmail = _user.email;
        _userAvatarUrl = _user.photoURL;
      });

      if (!_user.emailVerified) {
        //_isVerified = true;
        Timer.run(() => _showEmailVerifyDialog(context));
      }

      _provider = _user.providerData.elementAt(0).providerId;
      
      if (_provider == 'google.com') {
        _isGoogleUser = true;
      }
    }
    else {
      final _uuid = await _sharedPreferencesHelper.getUuid();

      if (_uuid == null) {
        FirestoreHelper().addUser(null, null);
        await _sharedPreferencesHelper.getUuid().then((uuid) {
          setState(() {
            _userId = uuid;            
          });
        });
      }
      else {
        setState(() {
          _userId = _uuid;          
        });
      }
    }

  }

  Future<void> _getYtPlaylist() async {
    // Set YouTube textfield text with the saved playlist URL
    await FirestoreHelper().getYouTubePlaylistUrl(_userId).then((String url) {
      if (!mounted) return;

      setState(() {
        _ytPlaylistUrlController.text = url;
      });
    });
  }

  // Spotify variables
  SpotifyConnectStatus _spotifyConnectStatus;
  SpotifyApi _spotify;
  String _spotifyDisplayName = '';
  Map<String, String> _spotifyPlaylists = new Map<String, String>();
  List<String> _spotifyPlaylistsNames = [];
  String _dropdownMenuValue;


  Future<void> _getSpotifyUser(SpotifyApi spotifyApi) async {
    // Set Spotify textfield text with current Spotify users name
    await SpotifyUtils().getUser(_spotify).then((User user) {
      if (!mounted) return;

      setState(() {
        _spotifyUsernameController.text = user.displayName;
        _spotifyDisplayName = user.displayName;
      });
    }); 
  }

  Future<Map<String, String>> _getSpotifyPlaylists(SpotifyApi spotifyApi) async {
    await SpotifyUtils().getAllPlaylists(_spotify).then((Map<String, String> playlists) {
      if (!mounted) return;

      setState(() {
        _spotifyPlaylistsNames.clear();

        playlists.forEach((key, value) { 
          _spotifyPlaylistsNames.add(value);
        });
        _dropdownMenuValue = _spotifyPlaylistsNames.first;  
      });
      _spotifyPlaylists = playlists;
    });
    
    return _spotifyPlaylists;
  }

  Future<void> _connectToSpotify(BuildContext context) async {
    if (_spotifyConnectStatus == SpotifyConnectStatus.disconnected && (_user != null || _userId != null)) {
      setState(() {
        _spotifyConnectStatus = SpotifyConnectStatus.connecting;        
      });
    }

    // Connect Spotify
    await SpotifyUtils().connectWithCredentials(context, _userId).then((SpotifyApi spotifyApi) {
      if (spotifyApi == null) return;
      if (!mounted) return;

      if (spotifyApi == null) {
        setState(() {
          _spotifyConnectStatus = SpotifyConnectStatus.disconnected;          
        });
      }

      setState(() {
        _spotify = spotifyApi;

        _getSpotifyUser(spotifyApi);
        _getSpotifyPlaylists(spotifyApi);
        _spotifyConnectStatus = SpotifyConnectStatus.connected;
      });
    });
  }

  String _getSpotifyPlaylistId(String playlistName) {
    String playlistId = '';
    playlistId = _spotifyPlaylists.keys.firstWhere((key) => _spotifyPlaylists[key] == playlistName, orElse: () => '');

    return playlistId;
  }

  @override
  void initState() {
    initialTimer();

    _sharedPreferencesHelper = new SharedPreferencesHelper();

    _syncStatus = SyncStatus.noSync;
    _spotifyConnectStatus = SpotifyConnectStatus.disconnected;

    _ytPlaylistUrlController = new TextEditingController();
    _spotifyUsernameController = new TextEditingController();

    _getUserData();

    _getYtPlaylist();
    _connectToSpotify(context);     

    super.initState();
  }

  @override
  void dispose() {
    _spotifyUsernameController.dispose();
    _ytPlaylistUrlController.dispose();
  
    super.dispose();
  }

  void _showEmailVerifyDialog(BuildContext context) {
    showDialog(context: context,
      builder: (context) => VerifyEmailDialog(
        user: _user,
        email: _userEmail,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => ButtonPressedHandler().onBackButtonExit(context),
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        body: Builder(
          builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                _spotifyConnectStatus = SpotifyConnectStatus.connecting;
                await _getUserData();
                await _connectToSpotify(context);
                await _getYtPlaylist();
              },
              backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
              color: ThemeProvider.themeOf(context).data.accentColor,
              displacement: SizeConfig.heightMultiplier * 5,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),              
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
                              highlightColor: Colors.transparent,
                              onPressed: () => ButtonPressedHandler().changeThemeButton(context),
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
                            
                            Padding(padding: EdgeInsets.only(left: 10)),

                            // Account Button
                            TextButton(
                              onPressed: () async {
                                if (_isUserLoggedIn) {
                                  ButtonPressedHandler().pushAndReplaceToPage(context, AccountPage());
                                }
                                else {
                                  ButtonPressedHandler().pushToPage(context, LoginPage(), () async {
                                    await _getUserData();
                                    if (_user != null) {
                                      await _connectToSpotify(context);
                                      await _getYtPlaylist();                             
                                    }
                                  });                         
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  if (_isUserLoggedIn && _isGoogleUser)
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        _userAvatarUrl,
                                      ),
                                      radius: 10,
                                      backgroundColor: Colors.transparent,
                                      onBackgroundImageError: (_,__) {
                                        setState(() {
                                          this._avatarLoadError = true;
                                        });
                                      },
                                      child: _avatarLoadError ? Icon(Icons.account_circle, color: Colors.grey, size: 20) : null,
                                    )
                                  else 
                                    Icon(
                                      Icons.account_circle,
                                      color: Colors.grey,
                                      size: 20
                                    ),

                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    (_isUserLoggedIn && _isGoogleUser) ? _username : _userEmail ?? 'Sign In',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Header Text
                      AnimatedPositioned(
                        duration: Duration(seconds: 1,),
                        top: _startAnimation ? SizeConfig.heightMultiplier * 22 : SizeConfig.heightMultiplier * 22,
                        left: _startAnimation ? SizeConfig.widthMultiplier * 8 : SizeConfig.widthMultiplier * -80,
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
                              TextSpan(text: 'Add Songs from ',),
                              TextSpan(
                                text: 'YouTube',
                                style: TextStyle(
                                  color: const Color(0xffff0000),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(text: '\nplaylists automatically\nto your ',),
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
                      AnimatedPositioned(
                        duration: Duration(seconds: 1,),
                        top: _startAnimation ? SizeConfig.heightMultiplier * 38 : SizeConfig.heightMultiplier * 38,
                        right: _startAnimation ? SizeConfig.widthMultiplier * 2 : SizeConfig.widthMultiplier * -140,
                        curve: Curves.ease,
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

                      // Spotify Widget
                      AnimatedPositioned(
                        duration: Duration(seconds: 1,),
                        left: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                        curve: Curves.ease,
                        child: Container(
                          height: SizeConfig.heightMultiplier * 100,
                          width: SizeConfig.widthMultiplier * 80,
                          alignment: Alignment.center,
                          child: Center(
                            child: SpotifyWidget(
                              connectStatus: _spotifyConnectStatus,
                              isIntroduction: false,
                              onConnectButtonPressed: () async {
                                if (_spotifyConnectStatus == SpotifyConnectStatus.disconnected) {
                                  setState(() {
                                    _spotifyConnectStatus = SpotifyConnectStatus.connecting;                                
                                  });
                                }
                                else {
                                  return;
                                }

                                await SpotifyUtils().connect(context).then((SpotifyApi spotifyApi) async {
                                  SpotifyApiCredentials _spotifyCredentials = await spotifyApi.getCredentials();
                                  await FirestoreHelper().saveSpotifyCredentials(_spotifyCredentials, _userId);
                                
                                  await SpotifyUtils().createPlaylist(context, spotifyApi, _userId);

                                  if (!mounted) return;

                                  setState(() {
                                    _spotify = spotifyApi;
                                    _getSpotifyUser(spotifyApi);
                                    _getSpotifyPlaylists(spotifyApi);

                                    _spotifyConnectStatus = SpotifyConnectStatus.connected;
                                  });
                                })
                                .onError((error, stackTrace) {
                                  print('ERROR Spotify Auth: $error, StackTrace:\n $stackTrace');
                                  CustomSnackbar.show(
                                    context,
                                    'Oops! Something went wrong. Please try again.',
                                  );
                                });
                              },
                              spotifyDisplayName: _spotifyDisplayName,
                              dropdownValue: _dropdownMenuValue,
                              dropdownItems: _spotifyPlaylistsNames
                                .map((String item) {
                                  return new DropdownMenuItem<String>(value: item, child: Text(item));
                                })
                                .toList(),
                              onDropdownChanged: (var value) {
                                setState(() {
                                  _dropdownMenuValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      // YouTube Playlist Input
                      AnimatedPositioned(
                        duration: Duration(seconds: 1,),
                        right: _startAnimation ? SizeConfig.widthMultiplier * 10 : SizeConfig.widthMultiplier * -100,
                        curve: Curves.ease,
                        child: Container(
                          height: SizeConfig.heightMultiplier * 100,
                          width: SizeConfig.widthMultiplier * 80,
                          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 22),
                          alignment: Alignment.center,
                          child: YtPlaylistUrlInputField(
                            controller: _ytPlaylistUrlController,
                            onEditingComplete: () async {
                              await YouTubeUtils().getPlaylistId(context, _ytPlaylistUrlController.text).then((value) async {
                                if (value != null) {
                                  await FirestoreHelper().saveYouTubePlaylistUrl(_ytPlaylistUrlController.text, _userId);
                                }
                              });
                            },
                            suffixIconButton: IconButton(
                              icon: Icon(Icons.delete_outline_rounded),
                              iconSize: 20,
                              padding: EdgeInsets.zero,
                              color: ThemeProvider.themeOf(context).data.primaryColor,
                              onPressed: () {
                                _ytPlaylistUrlController.clear();
                              },
                              tooltip: 'Clear YouTube playlist URL',
                            ),
                          ),
                        ),
                      ),
                      
                      // Sync Button
                      AnimatedPositioned(
                        duration: Duration(seconds: 1,),
                        bottom: SizeConfig.heightMultiplier * 20,
                        left: _startAnimation ? SizeConfig.widthMultiplier * 0 : SizeConfig.widthMultiplier * -100,
                        curve: Curves.ease,
                        child: SyncButton(
                          syncStatus: _syncStatus,
                          onPressed: () async {
                            setState(() {
                              if (_syncStatus == SyncStatus.noSync) {
                                _syncStatus = SyncStatus.syncing;
                              }
                              else
                                return;
                            });

                            await ButtonPressedHandler().syncPlaylistsButton(
                              context,
                              _spotify,
                              _getSpotifyPlaylistId(_dropdownMenuValue),
                              _ytPlaylistUrlController.text,
                              _userId
                            ).then((_) {
                              setState(() {
                                _syncStatus = SyncStatus.done;
                              });

                              Timer(Duration(milliseconds: 3300), () {
                                setState(() {
                                  _syncStatus = SyncStatus.noSync;                            
                                });
                              });
                            });
                          },
                        ),
                      ),

                      NoNetworkConnection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}