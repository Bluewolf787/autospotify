import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  SharedPreferences _sharedPreferences;

  Future<void> setIntroSeenBool() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    await _sharedPreferences.setBool('introSeen', true);
  }

  Future<bool> getIntroSeenBool() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    return (_sharedPreferences.getBool('introSeen') ?? false);
  }

  Future<void> setAutoPlaylistExistsBool() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    await _sharedPreferences.setBool('autoPlaylistExists', true);
  }

  Future<bool> getAutoPlaylistExistsBool() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    return (_sharedPreferences.getBool('autoPlaylistExists') ?? false);
  }

  Future<void> saveUuid(String uuid) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    await _sharedPreferences.setString('uuid', uuid);
  }

  Future<String> getUuid() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    return _sharedPreferences.getString('uuid');
  }

  Future<void> setLanguage(String language) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    await _sharedPreferences.setString('language', language);
  }

  Future<String> getCurrentLanguage() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    return _sharedPreferences.getString('language');
  }
}