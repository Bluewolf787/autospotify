import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr')
  ];

  /// Button text 'go'
  ///
  /// In en, this message translates to:
  /// **'go'**
  String get btnGo;

  /// Button text 'next'
  ///
  /// In en, this message translates to:
  /// **'next'**
  String get btnNext;

  /// Button text 'finish'
  ///
  /// In en, this message translates to:
  /// **'finish'**
  String get btnFinish;

  /// Button text 'BacK'
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get btnBack;

  /// Button text 'Light'
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get btnLight;

  /// Button text 'Dark'
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get btnDark;

  /// Button text 'yes'
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get btnYes;

  /// Button text 'no'
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get btnNo;

  /// Button text 'ok'
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get btnOk;

  /// Button text 'try again'
  ///
  /// In en, this message translates to:
  /// **'try again'**
  String get btnTryAgain;

  /// Button text 'Connect Spotify'
  ///
  /// In en, this message translates to:
  /// **'Connect Spotify'**
  String get btnConnectSpotify;

  /// Spotify text field text
  ///
  /// In en, this message translates to:
  /// **'Hello, '**
  String get spotifyTextField;

  /// YouTube text field label text
  ///
  /// In en, this message translates to:
  /// **'YouTube playlist URL'**
  String get ytLabelText;

  /// YouTube text field hint text
  ///
  /// In en, this message translates to:
  /// **'Enter your YouTube playlist URL'**
  String get ytHintText;

  /// tooltip text for clear text field
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearToolTip;

  /// No description provided for @changeThemeToolTip.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get changeThemeToolTip;

  /// Error message: unexpected error
  ///
  /// In en, this message translates to:
  /// **'Oops! Something unexpected happened'**
  String get unexpectedError;

  /// Error message: Spotify save error
  ///
  /// In en, this message translates to:
  /// **'Failed to save the credentials'**
  String get spotifySaveError;

  /// Error message: something went wrong
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong. Please try again'**
  String get somthingWrongError;

  /// Error message: Failed to connect Spotify
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to Spotify'**
  String get spotifyConnectError;

  /// Error message: Failed to sync playlists
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while syncing'**
  String get syncingError;

  /// Error message: No Songs found in YouTube playlist
  ///
  /// In en, this message translates to:
  /// **'Cloud not find any songs in that YouTube playlist'**
  String get noSongsFoundError;

  /// Error message: Failed to get the YouTube playlist
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong while getting the YouTube playlist. Please check the provided URL'**
  String get gettingYtPlaylistError;

  /// Error message: Invalid YouTube playlist URL
  ///
  /// In en, this message translates to:
  /// **'The provided YouTube playlist URL is not valid'**
  String get ytUrlInvalid;

  /// No description provided for @connectSpotifyFirstWarning.
  ///
  /// In en, this message translates to:
  /// **'Please connect your Spotify profile with AutoSpotify before move on'**
  String get connectSpotifyFirstWarning;

  /// Songs are already in the Spotify playlist warning
  ///
  /// In en, this message translates to:
  /// **'Those songs are already in that Spotify playlist'**
  String get songsAlreadyInPlaylistWarning;

  /// No YouTube playlist URL provide warning
  ///
  /// In en, this message translates to:
  /// **'Please enter a YouTube playlist'**
  String get noYtPlaylistWarning;

  /// Playlists are successfully synced message
  ///
  /// In en, this message translates to:
  /// **'Playlists successfully synced'**
  String get successfulSync;

  /// Text for NoNetworkConnection page
  ///
  /// In en, this message translates to:
  /// **'no network connection'**
  String get noNetworkConnection;

  /// Header text for exit dialog
  ///
  /// In en, this message translates to:
  /// **'Exit AutoSpotify'**
  String get exitHeader;

  /// Content text for exit dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure to exit?'**
  String get exitContent;

  /// First section of intro startpage header text
  ///
  /// In en, this message translates to:
  /// **'Before you can use\n'**
  String get introStartSpan1;

  /// Second section of intro startpage header text
  ///
  /// In en, this message translates to:
  /// **'to automatically\ngenerate '**
  String get introStartSpan2;

  /// Third section of intro startpage header text
  ///
  /// In en, this message translates to:
  /// **'playlists,\nyou need to do some\nsteps first'**
  String get introStartSpan3;

  /// First section of choose theme page header text
  ///
  /// In en, this message translates to:
  /// **'Choose your favorite color\n'**
  String get chooseThemeSpan1;

  /// Second section of choose theme page header text
  ///
  /// In en, this message translates to:
  /// **'theme'**
  String get chooseThemeSpan2;

  /// This third section of choose theme page header text is for die french language
  ///
  /// In en, this message translates to:
  /// **''**
  String get chooseThemeSpanFr;

  /// First section of Spotify intro page header text
  ///
  /// In en, this message translates to:
  /// **'You must authorize\n'**
  String get introSpotifySpan1;

  /// Second section of Spotify intro page header text
  ///
  /// In en, this message translates to:
  /// **' to connect\nto your '**
  String get introSpotifySpan2;

  /// Third section of Spotify intro page header text
  ///
  /// In en, this message translates to:
  /// **' account'**
  String get introSpotifySpan3;

  /// First section of YouTube intro page header text
  ///
  /// In en, this message translates to:
  /// **'And provide a '**
  String get introYtSpan1;

  /// Second section of YouTube intro page header text
  ///
  /// In en, this message translates to:
  /// **'\nplaylist you want\nto synchronize'**
  String get introYtSpan2;

  /// First section of home page header text
  ///
  /// In en, this message translates to:
  /// **'Add Songs from '**
  String get homePageSpan1;

  /// Second section of home page header text
  ///
  /// In en, this message translates to:
  /// **'\nplaylists automatically\nto your '**
  String get homePageSpan2;

  /// Third section of home page header text
  ///
  /// In en, this message translates to:
  /// **' playlist'**
  String get homePageSpan3;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
// Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
