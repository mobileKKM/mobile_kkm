import 'package:intl/intl.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';

/// The age below which an account can only be opened on the EKP website.
const _fullAge = 16;

/// Whether someone born on [birthDate] is under 16 at [now].
bool isUnder16(DateTime birthDate, DateTime now) =>
    now.isBefore(DateTime(birthDate.year + _fullAge, birthDate.month, birthDate.day));

/// The website's registration form with what was already typed here, as the
/// official client hands a minor over: `{customerPageUrl}auth/register?…`.
///
/// [customerPageUrl] comes from the app config; without it the site is
/// assumed to be at the host of the e-mail links.
Uri websiteRegistrationUri({
  required String? customerPageUrl,
  required String firstName,
  required String lastName,
  required String email,
  required String repeatEmail,
  required String? pesel,
  required DateTime? birthDate,
}) {
  final site = customerPageUrl == null || customerPageUrl.isEmpty ? 'https://$ekpLinkHost' : customerPageUrl;
  return Uri.parse('${site.endsWith('/') ? site : '$site/'}auth/register').replace(
    queryParameters: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'repeatEmail': repeatEmail,
      'isNoPesel': '${pesel == null}',
      'pesel': ?pesel,
      if (birthDate != null) 'birthDate': DateFormat('yyyy-MM-dd').format(birthDate),
    },
  );
}
