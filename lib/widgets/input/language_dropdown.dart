import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/supported_languages.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class LanguageSelector extends StatelessWidget {
  LanguageSelector({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final List<DropdownMenuItem<String>>? languages = [
    DropdownMenuItem<String>(
      child: Text('English'),
      value: SupportedLanguages.LANGUAGES['en'],
    ),
    DropdownMenuItem<String>(
      child: Text('German'),
      value: SupportedLanguages.LANGUAGES['de'],
    ),
    DropdownMenuItem<String>(
      child: Text('French'),
      value: SupportedLanguages.LANGUAGES['fr'],
    ),
  ];
  final String? value;
  final dynamic Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.widthMultiplier! * 26,
      child: DropdownButton(
        items: languages,
        value: value,
        onChanged: onChanged,
        isDense: false,
        isExpanded: true,
        autofocus: false,
        iconSize: 16,
        icon: Icon(Icons.language_rounded),
        iconEnabledColor: ThemeProvider.themeOf(context).data.primaryColor,
        elevation: 16,
        dropdownColor: ThemeProvider.themeOf(context).data.canvasColor,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: ThemeProvider.themeOf(context).data.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
