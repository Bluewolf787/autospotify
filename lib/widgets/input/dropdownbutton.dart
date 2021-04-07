import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class SpotifyPlaylistSelectButton extends StatelessWidget {
  const SpotifyPlaylistSelectButton({
    Key key,
    this.items,
    this.value,
    this.onChanged,
    this.spotifyDisplayName,
  }) : super(key: key);

  final List<DropdownMenuItem> items;
  final dynamic value;
  final ValueChanged onChanged;
  final String spotifyDisplayName;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      value: value,
      onChanged: onChanged,
      isDense: true,
      isExpanded: true,
      autofocus: false,
      iconSize: 24,
      elevation: 16,
      dropdownColor: ThemeProvider.themeOf(context).data.canvasColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: const Color(0xff1db954),
            width: 2.0
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: const Color(0xff1db954),
            width: 2.0
          ),
        ),
        labelText: '$spotifyDisplayName - Spotify Playlist:',
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: ThemeProvider.themeOf(context).data.primaryColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}