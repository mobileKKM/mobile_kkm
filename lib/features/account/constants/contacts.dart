/// Where the account screen's contact rows lead.
abstract final class Contacts {
  /// The MPK S.A. helpline and eKP mailbox, as given in the official app.
  static const mpkPhone = '12 19 150';
  static final mpkPhoneUri = Uri(scheme: 'tel', path: '+481219150');
  static const mpkEmail = 'ekp@mpk.krakow.pl';

  static const developerEmail = 'mobilekkm@codebucket.de';
  static const issuesLabel = 'github.com/mobileKKM/mobile_kkm';
  static final issuesUri = Uri.parse('https://github.com/mobileKKM/mobile_kkm/issues');

  /// The app's source code, linked from the first start notice.
  static final sourceUri = Uri.parse('https://github.com/mobileKKM/mobile_kkm');

  /// Where new versions of the app are published: the GitHub releases, unless the build names its own store with
  /// `--dart-define=UPDATE_URL=…` (F-Droid, Google Play).
  static final releasesUri = Uri.parse(
    const String.fromEnvironment('UPDATE_URL', defaultValue: 'https://github.com/mobileKKM/mobile_kkm/releases'),
  );

  /// Where the city explains how to get Karta Krakowska. The app cannot
  /// grant the status itself.
  static final cityCardHowToUri = Uri.parse('https://kk.krakow.pl/jak-wyrobic-karte-krakowska');

  static Uri mailto(String address) => Uri(scheme: 'mailto', path: address);
}
