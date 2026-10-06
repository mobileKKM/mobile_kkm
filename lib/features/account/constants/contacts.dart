/// Where the account screen's contact rows lead.
abstract final class Contacts {
  /// The MPK S.A. helpline and EKP mailbox, as given in the official app.
  static const mpkPhone = '12 19 150';
  static final mpkPhoneUri = Uri(scheme: 'tel', path: '+481219150');
  static const mpkEmail = 'ekp@mpk.krakow.pl';

  static const developerEmail = 'mobilekkm@codebucket.de';
  static const issuesLabel = 'github.com/mobileKKM/mobile_kkm';
  static final issuesUri = Uri.parse('https://github.com/mobileKKM/mobile_kkm/issues');

  /// Where new versions of the app are published.
  static final releasesUri = Uri.parse('https://github.com/mobileKKM/mobile_kkm/releases');

  static Uri mailto(String address) => Uri(scheme: 'mailto', path: address);
}
