import 'dart:async';

import 'package:autospotify/l10n/app_localizations.dart';
import 'package:autospotify/utils/db/firestore_helper.dart';
import 'package:autospotify/utils/db/shared_prefs_helper.dart';
import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/button_pressed_handler.dart';
import 'package:autospotify/utils/spotify/spotify_connect_status.dart';
import 'package:autospotify/utils/spotify/spotify_utils.dart';
import 'package:autospotify/utils/sync_status.dart';
import 'package:autospotify/utils/youtube/youtube_utils.dart';
import 'package:autospotify/widgets/buttons/buttons.dart';
import 'package:autospotify/widgets/dialogs/snackbar.dart';
import 'package:autospotify/widgets/input/language_dropdown.dart';
import 'package:autospotify/widgets/input/textfields.dart';
import 'package:autospotify/widgets/layout/no_network_connection.dart';
import 'package:autospotify/widgets/spotify_widget.dart';
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? _spotifyUsernameController;
  TextEditingController? _ytPlaylistUrlController;

  var _startAnimation = false;
  initialTimer() async {
    await new Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _startAnimation = true;
    });
  }

  SyncStatus? _syncStatus;
  SharedPreferencesHelper? _sharedPreferencesHelper;
  String? _userId;

  // Get the ID of current user
  Future<void> _getUserId() async {
    final _uuid = await _sharedPreferencesHelper!.getUuid();

    setState(() {
      _userId = _uuid;
    });
  }

  Future<void> _getYtPlaylist() async {
    // Set YouTube textfield text with the saved playlist URL
    await FirestoreHelper().getYouTubePlaylistUrl(_userId).then((String? url) {
      if (!mounted) return;

      setState(() {
        _ytPlaylistUrlController!.text = url!;
      });
    });
  }

  // Spotify variables
  SpotifyConnectStatus _spotifyConnectStatus =
      SpotifyConnectStatus.disconnected;
  late SpotifyApi _spotify;
  String _spotifyDisplayName = '';
  Map<String, String> _spotifyPlaylists = new Map<String, String>();
  List<String> _spotifyPlaylistsNames = [];
  String? _dropdownMenuValue;

  Future<void> _getSpotifyUser(SpotifyApi spotifyApi) async {
    // Set Spotify textfield text with current Spotify users name
    await SpotifyUtils().getUser(_spotify).then((User user) {
      if (!mounted) return;

      setState(() {
        _spotifyUsernameController!.text = user.displayName!;
        _spotifyDisplayName = user.displayName!;
      });
    });
  }

  Future<Map<String, String>> _getSpotifyPlaylists(
      SpotifyApi spotifyApi) async {
    await SpotifyUtils()
        .getAllPlaylists(_spotify)
        .then((Map<String, String> playlists) {
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
    if (_spotifyConnectStatus == SpotifyConnectStatus.disconnected &&
        (_userId != null)) {
      setState(() {
        _spotifyConnectStatus = SpotifyConnectStatus.connecting;
      });
    }

    // Connect Spotify
    await SpotifyUtils()
        .connectWithCredentials(context, _userId)
        .then((SpotifyApi? spotifyApi) {
      if (spotifyApi!.getCredentials() == null) return;
      if (!mounted) return;

      if (spotifyApi.getCredentials() == null) {
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
    playlistId = _spotifyPlaylists.keys.firstWhere(
        (key) => _spotifyPlaylists[key] == playlistName,
        orElse: () => '');

    return playlistId;
  }

  String? _currentLanguage;
  void _getCurrentLanguage() async {
    SharedPreferencesHelper().getCurrentLanguage().then((language) {
      setState(() {
        _currentLanguage = language;
      });
    });
  }

  @override
  void initState() {
    initialTimer();

    _sharedPreferencesHelper = new SharedPreferencesHelper();

    _syncStatus = SyncStatus.noSync;
    _spotifyConnectStatus = SpotifyConnectStatus.disconnected;

    _ytPlaylistUrlController = new TextEditingController();
    _spotifyUsernameController = new TextEditingController();

    _getCurrentLanguage();

    _getUserId();

    _getYtPlaylist();
    _connectToSpotify(context);

    super.initState();
  }

  @override
  void dispose() {
    _spotifyUsernameController!.dispose();
    _ytPlaylistUrlController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor:
          ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
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
              await _connectToSpotify(context);
              await _getYtPlaylist();
            },
            backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
            color: ThemeProvider.themeOf(context).data.accentColor,
            displacement: SizeConfig.heightMultiplier! * 5,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: SizeConfig.widthMultiplier! * 100,
                height: SizeConfig.heightMultiplier! * 100,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: SizeConfig.heightMultiplier! * 3.160806006,
                      right: SizeConfig.widthMultiplier! * 6.111535523,
                      // Theme Change Button
                      child: Row(
                        children: <Widget>[
                          LanguageSelector(
                            value: _currentLanguage,
                            onChanged: (String? newLanguage) {
                              setState(() {
                                _currentLanguage = newLanguage;
                                MyApp.of(context)!.setLocale(_currentLanguage);
                              });
                            },
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            icon: ThemeProvider.themeOf(context).id ==
                                    'light_theme'
                                ? Icon(Icons.wb_sunny)
                                : Icon(Icons.nightlight_round),
                            color: ThemeProvider.themeOf(context).id ==
                                    'light_theme'
                                ? Colors.yellow
                                : Colors.grey,
                            tooltip: AppLocalizations.of(context)!
                                .changeThemeToolTip,
                            highlightColor: Colors.transparent,
                            onPressed: () => ButtonPressedHandler()
                                .changeThemeButton(context),
                          ),
                        ],
                      ),
                    ),

                    // Header Text
                    AnimatedPositioned(
                      duration: Duration(
                        seconds: 1,
                      ),
                      top: _startAnimation
                          ? SizeConfig.heightMultiplier! * 21
                          : SizeConfig.heightMultiplier! * 21,
                      left: _startAnimation
                          ? SizeConfig.widthMultiplier! * 8
                          : SizeConfig.widthMultiplier! * -80,
                      curve: Curves.ease,
                      child: Container(
                        width: SizeConfig.widthMultiplier! * 80,
                        height: SizeConfig.heightMultiplier! * 15,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 26,
                                fontWeight: FontWeight.w400,
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColor,
                                height: 1.3,
                              ),
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .homePageSpan1,
                                ),
                                TextSpan(
                                  text: 'YouTube',
                                  style: TextStyle(
                                    color: const Color(0xffff0000),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .homePageSpan2,
                                ),
                                TextSpan(
                                  text: 'Spotify',
                                  style: TextStyle(
                                    color: const Color(0xff1db954),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .homePageSpan3,
                                ),
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .accentColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),

                    // Lines
                    AnimatedPositioned(
                      duration: Duration(
                        seconds: 1,
                      ),
                      top: _startAnimation
                          ? SizeConfig.heightMultiplier! * 38
                          : SizeConfig.heightMultiplier! * 38,
                      right: _startAnimation
                          ? SizeConfig.widthMultiplier! * 2
                          : SizeConfig.widthMultiplier! * -140,
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
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .accentColor,
                                thickness: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Spotify Widget
                    AnimatedPositioned(
                      duration: Duration(
                        seconds: 1,
                      ),
                      left: _startAnimation
                          ? SizeConfig.widthMultiplier! * 10
                          : SizeConfig.widthMultiplier! * -100,
                      curve: Curves.ease,
                      child: Container(
                        height: SizeConfig.heightMultiplier! * 100,
                        width: SizeConfig.widthMultiplier! * 80,
                        alignment: Alignment.center,
                        child: Center(
                          child: SpotifyWidget(
                            connectStatus: _spotifyConnectStatus,
                            isIntroduction: false,
                            onConnectButtonPressed: () async {
                              if (_spotifyConnectStatus ==
                                  SpotifyConnectStatus.disconnected) {
                                setState(() {
                                  _spotifyConnectStatus =
                                      SpotifyConnectStatus.connecting;
                                });
                              } else {
                                return;
                              }

                              await SpotifyUtils()
                                  .connect(context)
                                  .then((SpotifyApi spotifyApi) async {
                                SpotifyApiCredentials _spotifyCredentials =
                                    await spotifyApi.getCredentials();
                                await FirestoreHelper().saveSpotifyCredentials(
                                    _spotifyCredentials, _userId);

                                await SpotifyUtils().createPlaylist(
                                    context, spotifyApi, _userId);

                                if (!mounted) return;

                                setState(() {
                                  _spotify = spotifyApi;
                                  _getSpotifyUser(spotifyApi);
                                  _getSpotifyPlaylists(spotifyApi);

                                  _spotifyConnectStatus =
                                      SpotifyConnectStatus.connected;
                                });
                              }).onError((error, stackTrace) {
                                print(
                                    'ERROR Spotify Auth: $error, StackTrace:\n $stackTrace');
                                CustomSnackbar.show(
                                  context,
                                  AppLocalizations.of(context)!
                                      .somthingWrongError,
                                );
                              });
                            },
                            spotifyDisplayName: _spotifyDisplayName,
                            dropdownValue: _dropdownMenuValue,
                            dropdownItems:
                                _spotifyPlaylistsNames.map((String item) {
                              return new DropdownMenuItem<String>(
                                  value: item, child: Text(item));
                            }).toList(),
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
                      duration: Duration(
                        seconds: 1,
                      ),
                      right: _startAnimation
                          ? SizeConfig.widthMultiplier! * 10
                          : SizeConfig.widthMultiplier! * -100,
                      curve: Curves.ease,
                      child: Container(
                        height: SizeConfig.heightMultiplier! * 100,
                        width: SizeConfig.widthMultiplier! * 80,
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier! * 22),
                        alignment: Alignment.center,
                        child: YtPlaylistUrlInputField(
                          controller: _ytPlaylistUrlController!,
                          onEditingComplete: () async {
                            await YouTubeUtils()
                                .getPlaylistId(
                                    context, _ytPlaylistUrlController!.text)
                                .then((value) async {
                              if (value != null) {
                                await FirestoreHelper().saveYouTubePlaylistUrl(
                                    _ytPlaylistUrlController!.text, _userId);
                              }
                            });
                          },
                          suffixIconButton: IconButton(
                            icon: Icon(Icons.delete_outline_rounded),
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .primaryColor,
                            onPressed: () {
                              _ytPlaylistUrlController!.clear();
                            },
                            tooltip: AppLocalizations.of(context)!.clearToolTip,
                          ),
                        ),
                      ),
                    ),

                    // Sync Button
                    AnimatedPositioned(
                      duration: Duration(
                        seconds: 1,
                      ),
                      bottom: SizeConfig.heightMultiplier! * 20,
                      left: _startAnimation
                          ? SizeConfig.widthMultiplier! * 0
                          : SizeConfig.widthMultiplier! * -100,
                      curve: Curves.ease,
                      child: SyncButton(
                        syncStatus: _syncStatus!,
                        onPressed: () async {
                          setState(() {
                            if (_syncStatus == SyncStatus.noSync) {
                              _syncStatus = SyncStatus.syncing;
                            } else
                              return;
                          });

                          await ButtonPressedHandler()
                              .syncPlaylistsButton(
                                  context,
                                  _spotify,
                                  _getSpotifyPlaylistId(_dropdownMenuValue!),
                                  _ytPlaylistUrlController!.text,
                                  _userId!)
                              .then((status) {
                            setState(() {
                              status
                                  ? _syncStatus = SyncStatus.done
                                  : _syncStatus = SyncStatus.error;
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
    );
  }
}
