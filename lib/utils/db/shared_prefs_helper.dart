import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  Future<void> setIntroSeenBool() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setBool('introSeen', true);
  }

  Future<bool> getIntroSeenBool() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return (sharedPreferences.getBool('introSeen') ?? false);
  }

  Future<void> setAutoPlaylistExistsBool() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setBool('autoPlaylistExists', true);
  }

  Future<bool> getAutoPlaylistExistsBool() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return (sharedPreferences.getBool('autoPlaylistExists') ?? false);
  }

  Future<void> saveUuid(String uuid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('uuid', uuid);
  }

  Future<String> getUuid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString('uuid');
  }
}