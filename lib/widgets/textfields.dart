import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key key,
    @required this.controller,
    this.onEditingComplete,
    this.readOnly,
    this.passwordField,
    this.emailField,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final Function onEditingComplete;
  final bool readOnly;
  final bool passwordField;
  final bool emailField;
  final String hintText;
  final String labelText;
  final Widget prefixIcon;
  final Widget suffixIcon;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: onEditingComplete,
      readOnly: readOnly,
      obscureText: passwordField ? true : false,
      enableSuggestions: passwordField ? false : true,
      autocorrect: passwordField ? false : true ?? true,
      keyboardType: emailField ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: ThemeProvider.themeOf(context).data.accentColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: ThemeProvider.themeOf(context).data.accentColor,
            width: 2.0,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
        alignLabelWithHint: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      cursorColor: ThemeProvider.themeOf(context).data.accentColor,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: ThemeProvider.themeOf(context).data.primaryColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class SpotifyUsernameField extends StatelessWidget {
  SpotifyUsernameField({
    Key key,
    @required this.controller
  }) : super(key: key);
  
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => null,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Color(0xff1db954), width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Color(0xff1db954), width: 2.0,
          ),
        ),
        labelText: 'Spotify username',
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      cursorColor: Color(0xff1db954),
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: ThemeProvider.themeOf(context).data.primaryColor,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class YtPlaylistUrlInputField extends StatelessWidget {
  YtPlaylistUrlInputField({
    Key key,
    @required this.controller,
    this.onEditingComplete,
    this.suffixIconButton,
  }) : super(key: key);
  
  final TextEditingController controller;
  final Function onEditingComplete;
  final IconButton suffixIconButton;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: onEditingComplete,
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
        border: InputBorder.none,
        suffixIcon: suffixIconButton,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: const Color(0xffff0000),
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: const Color(0xffff0000),
            width: 2.0,
          ),
        ),
        labelText: 'YouTube playlist URL',
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
        alignLabelWithHint: true,
        hintText: 'Enter your YouTube playlist URL',
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      cursorColor: const Color(0xffff0000),
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: ThemeProvider.themeOf(context).data.primaryColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}