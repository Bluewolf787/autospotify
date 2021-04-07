import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/spotify/spotify_connect_status.dart';
import 'package:autospotify/widgets/buttons/spotify_connect_button.dart';
import 'package:autospotify/widgets/input/dropdownbutton.dart';
import 'package:autospotify/widgets/input/textfields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class SpotifyWidget extends StatelessWidget {
  SpotifyWidget({
    Key key,
    @required this.connectStatus,
    @required this.onConnectButtonPressed,
    this.isIntroduction,
    this.textFieldController,
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
    this.spotifyDisplayName,
  }) : super(key: key);

  final SpotifyConnectStatus connectStatus;
  final Function onConnectButtonPressed;
  final bool isIntroduction;
  final TextEditingController textFieldController;
  final List<DropdownMenuItem> dropdownItems;
  final dynamic dropdownValue;
  final ValueChanged onDropdownChanged;
  final String spotifyDisplayName;

  @override
  Widget build(BuildContext context) {
    if (connectStatus == SpotifyConnectStatus.disconnected) {
      return ConnectSpotifyButton(
        onPressed: onConnectButtonPressed,
      );
    }
    else if (!isIntroduction && connectStatus == SpotifyConnectStatus.connected) {
      return SpotifyPlaylistSelectButton(
        value: dropdownValue,
        spotifyDisplayName: spotifyDisplayName,
        items: dropdownItems,
        onChanged: onDropdownChanged,
      );
    }
    else if (isIntroduction && connectStatus == SpotifyConnectStatus.connected) {
      return SpotifyUsernameField(controller: textFieldController);
    }
    else {
      return SizedBox(
        height: SizeConfig.heightMultiplier * 8,
        width: SizeConfig.widthMultiplier * 80,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff1db954),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ThemeProvider.themeOf(context).data.primaryColor),
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }
  }
}