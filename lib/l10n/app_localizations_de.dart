


import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get btnGo => 'los';

  @override
  String get btnNext => 'weiter';

  @override
  String get btnFinish => 'fertigstellen';

  @override
  String get btnBack => 'Zurück';

  @override
  String get btnLight => 'Hell';

  @override
  String get btnDark => 'Dunkel';

  @override
  String get btnYes => 'ja';

  @override
  String get btnNo => 'nein';

  @override
  String get btnOk => 'ok';

  @override
  String get btnTryAgain => 'Erneut versuchen';

  @override
  String get btnConnectSpotify => 'Spotify verbinden';

  @override
  String get spotifyTextField => 'Hallo, ';

  @override
  String get ytLabelText => 'YouTube Playlist URL';

  @override
  String get ytHintText => 'Gib deine YouTube Playlist URL ein';

  @override
  String get clearToolTip => 'Löschen';

  @override
  String get changeThemeToolTip => 'Ändere das Farbschema';

  @override
  String get unexpectedError => 'Ups! Etwas lief anders als erwartet';

  @override
  String get spotifySaveError => 'Speichern der Spotify Anmeldeinformationen fehlgeschlagen';

  @override
  String get somethingWrongError => 'Ups! Etwas ist schiefgelaufen. Bitte versuche es erneut';

  @override
  String get spotifyConnectError => 'Verbinden zu Spotify fehlgeschlagen';

  @override
  String get syncingError => 'Ups! Beim synchronisieren ist etwas schiefgelaufen';

  @override
  String get noSongsFoundError => 'In der YouTube playlist konnten keine Lieder gefunden werden';

  @override
  String get gettingYtPlaylistError => 'Ups! Beim finden der YouTube Playlist ist etwas schiefgelaufen. Bitte überprüfe die angegebene Playlist URL';

  @override
  String get ytUrlInvalid => 'Die angegebene YouTube Playlist URL ist ungültig';

  @override
  String get connectSpotifyFirstWarning => 'Bitte verbinde dein Spotify Profil mit AutoSpotify bevor du weiter machst';

  @override
  String get songsAlreadyInPlaylistWarning => 'Die Lieder aus der YouTube Playlist sind bereits in der Spotify Playlist';

  @override
  String get noYtPlaylistWarning => 'Bitte gib eine YouTube Playlist an';

  @override
  String get successfulSync => 'Die Playlisten wurden erfolgreich synchronisiert';

  @override
  String get noNetworkConnection => 'keine Internetverbindung';

  @override
  String get exitHeader => 'AutoSpotify beenden';

  @override
  String get exitContent => 'Bist du sicher, dass du beenden möchtest?';

  @override
  String get introStartSpan1 => 'Bevor du mit ';

  @override
  String get introStartSpan2 => '\nPlaylisten automatisch\nin ';

  @override
  String get introStartSpan3 => 'generieren kannst,\nmusst du vorher noch ein\npaar Schritte tun';

  @override
  String get chooseThemeSpan1 => 'Wähle dein bevorzugtes\n';

  @override
  String get chooseThemeSpan2 => 'Farbschema';

  @override
  String get chooseThemeSpanFr => '';

  @override
  String get introSpotifySpan1 => 'Du musst ';

  @override
  String get introSpotifySpan2 => '\nautorisieren sich mit deinen\n';

  @override
  String get introSpotifySpan3 => ' Profil zu verbinden';

  @override
  String get introYtSpan1 => 'Zuletzt, gib deine\n';

  @override
  String get introYtSpan2 => ' Playlist an, die du\nsynchronisieren möchtest';

  @override
  String get homePageSpan1 => 'Füge Lieder aus ';

  @override
  String get homePageSpan2 => '\nPlaylisten automatisch\ndeiner ';

  @override
  String get homePageSpan3 => ' Playlist hinzu';

  @override
  String get songsFoundOnYouTube => 'Lieder wurden in der YouTube-Playlist gefunden';

  @override
  String get songsFoundOnSpotify => 'Lieder wurden auf Spotify gefunden';
}
