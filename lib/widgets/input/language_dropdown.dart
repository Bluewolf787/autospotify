import 'package:autospotify/utils/size_config.dart';
import 'package:autospotify/utils/supported_languages.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class LanguageSelector extends StatelessWidget {
  LanguageSelector({
    Key key,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  final List<String> languages = [SupportedLanguages.LANGUAGES['en'], SupportedLanguages.LANGUAGES['de'], SupportedLanguages.LANGUAGES['fr']];
  final String value;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.widthMultiplier * 26,
      child: DropdownButton(
        items: languages.map((String item) {
          return new DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
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