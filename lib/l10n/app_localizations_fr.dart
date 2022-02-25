


import 'app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get btnGo => 'allez-y';

  @override
  String get btnNext => 'Suivant';

  @override
  String get btnFinish => 'finir';

  @override
  String get btnBack => 'Retourner';

  @override
  String get btnLight => 'Brillant';

  @override
  String get btnDark => 'Sombre';

  @override
  String get btnYes => 'oui';

  @override
  String get btnNo => 'non';

  @override
  String get btnOk => 'd\'accord';

  @override
  String get btnTryAgain => 'réessayer';

  @override
  String get btnConnectSpotify => 'Connecter Spotify';

  @override
  String get spotifyTextField => 'Salut, ';

  @override
  String get ytLabelText => 'YouTube liste de lecture URL';

  @override
  String get ytHintText => 'Donnes l\'URL de votre liste de lecture YouTube';

  @override
  String get clearToolTip => 'Supprimer';

  @override
  String get changeThemeToolTip => 'Modifier le jeu de couleurs';

  @override
  String get unexpectedError => 'Oups! Quelque chose d\'inattendu est arrivé';

  @override
  String get spotifySaveError => 'Échec de l\'enregistrement des informations d\'identification de Spotify';

  @override
  String get somethingWrongError => 'Oups! Quelque chose s\'est mal passé. Veuillez réessayer';

  @override
  String get spotifyConnectError => 'Échec de la connexion à Spotify';

  @override
  String get syncingError => 'Oups! Un problème est survenu lors de la synchronisation';

  @override
  String get noSongsFoundError => 'Cloud ne trouve pas de chansons dans cette liste de lecture YouTube';

  @override
  String get gettingYtPlaylistError => 'Oups ! Un problème est survenu lors de l\'obtention de la liste de lecture YouTube. Veuillez vérifier l\'URL fournie';

  @override
  String get ytUrlInvalid => 'L\'URL de la liste de lecture YouTube spécifiée n\'est pas valide';

  @override
  String get connectSpotifyFirstWarning => 'Veuillez connecter votre profil Spotify avec AutoSpotify avant de continuer';

  @override
  String get songsAlreadyInPlaylistWarning => 'Les chansons de la liste de lecture YouTube sont déjà dans la liste de lecture Spotify';

  @override
  String get noYtPlaylistWarning => 'Veuillez entrer une liste de lecture YouTube';

  @override
  String get successfulSync => 'Les listes de lecture ont été synchronisées avec succès';

  @override
  String get noNetworkConnection => 'pas de connexion internet';

  @override
  String get exitHeader => 'Quitter AutoSpotify';

  @override
  String get exitContent => 'Tu es sûr de vouloir arrêter?';

  @override
  String get introStartSpan1 => 'Avant de pouvoir utiliser\n';

  @override
  String get introStartSpan2 => 'pour générer\nautomatiquement des listes\nde lecture dans ';

  @override
  String get introStartSpan3 => ',\nvous devez d\'abord effectuer\nquelques démarches';

  @override
  String get chooseThemeSpan1 => 'Choisissez votre\n';

  @override
  String get chooseThemeSpan2 => 'schéma de couleurs ';

  @override
  String get chooseThemeSpanFr => 'préféré';

  @override
  String get introSpotifySpan1 => 'Vous devez autoriser\n';

  @override
  String get introSpotifySpan2 => ' à se connecter\nà votre profil ';

  @override
  String get introSpotifySpan3 => '';

  @override
  String get introYtSpan1 => 'Enfin, indiquez la\nliste de lecture ';

  @override
  String get introYtSpan2 => ' que vous\nsouhaitez synchroniser';

  @override
  String get homePageSpan1 => 'Ajoutez automatiquement\nles chansons des\nlistes de lecture ';

  @override
  String get homePageSpan2 => '\nà votre liste de lecture ';

  @override
  String get homePageSpan3 => '';

  @override
  String get songsFoundOnYouTube => 'chansons trouvées dans la playlist YouTube';

  @override
  String get songsFoundOnSpotify => 'chansons trouvées sur Spotify';
}
