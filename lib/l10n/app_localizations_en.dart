


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get btnGo => 'go';

  @override
  String get btnNext => 'next';

  @override
  String get btnFinish => 'finish';

  @override
  String get btnBack => 'Back';

  @override
  String get btnLight => 'Light';

  @override
  String get btnDark => 'Dark';

  @override
  String get btnYes => 'yes';

  @override
  String get btnNo => 'no';

  @override
  String get btnOk => 'ok';

  @override
  String get btnTryAgain => 'try again';

  @override
  String get btnConnectSpotify => 'Connect Spotify';

  @override
  String get spotifyTextField => 'Hello, ';

  @override
  String get ytLabelText => 'YouTube playlist URL';

  @override
  String get ytHintText => 'Enter your YouTube playlist URL';

  @override
  String get clearToolTip => 'Clear';

  @override
  String get changeThemeToolTip => 'Change theme';

  @override
  String get unexpectedError => 'Oops! Something unexpected happened';

  @override
  String get spotifySaveError => 'Failed to save the credentials';

  @override
  String get somthingWrongError => 'Oops! Something went wrong. Please try again';

  @override
  String get spotifyConnectError => 'Failed to connect to Spotify';

  @override
  String get syncingError => 'Oops! Something went wrong while syncing';

  @override
  String get noSongsFoundError => 'Cloud not find any songs in that YouTube playlist';

  @override
  String get gettingYtPlaylistError => 'Oops! Something went wrong while getting the YouTube playlist. Please check the provided URL';

  @override
  String get ytUrlInvalid => 'The provided YouTube playlist URL is not valid';

  @override
  String get connectSpotifyFirstWarning => 'Please connect your Spotify profile with AutoSpotify before move on';

  @override
  String get songsAlreadyInPlaylistWarning => 'Those songs are already in that Spotify playlist';

  @override
  String get noYtPlaylistWarning => 'Please enter a YouTube playlist';

  @override
  String get successfulSync => 'Playlists successfully synced';

  @override
  String get noNetworkConnection => 'no network connection';

  @override
  String get exitHeader => 'Exit AutoSpotify';

  @override
  String get exitContent => 'Are you sure to exit?';

  @override
  String get introStartSpan1 => 'Before you can use\n';

  @override
  String get introStartSpan2 => 'to automatically\ngenerate ';

  @override
  String get introStartSpan3 => 'playlists,\nyou need to do some\nsteps first';

  @override
  String get chooseThemeSpan1 => 'Choose your favorite color\n';

  @override
  String get chooseThemeSpan2 => 'theme';

  @override
  String get chooseThemeSpanFr => '';

  @override
  String get introSpotifySpan1 => 'You must authorize\n';

  @override
  String get introSpotifySpan2 => ' to connect\nto your ';

  @override
  String get introSpotifySpan3 => ' account';

  @override
  String get introYtSpan1 => 'And provide a ';

  @override
  String get introYtSpan2 => '\nplaylist you want\nto synchronize';

  @override
  String get homePageSpan1 => 'Add Songs from ';

  @override
  String get homePageSpan2 => '\nplaylists automatically\nto your ';

  @override
  String get homePageSpan3 => ' playlist';
}
