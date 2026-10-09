import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/auth/utils/minor_registration.dart';

void main() {
  test('sixteen is reached on the birthday itself', () {
    final born = DateTime(2010, 6, 15);
    expect(isUnder16(born, DateTime(2026, 6, 14, 23, 59)), isTrue);
    expect(isUnder16(born, DateTime(2026, 6, 15)), isFalse);
    expect(isUnder16(born, DateTime(2030)), isFalse);
  });

  group('the website form', () {
    Uri uri({String? site, String? pesel, DateTime? birthDate}) => websiteRegistrationUri(
      customerPageUrl: site,
      firstName: 'Zoë',
      lastName: 'Nowak-Kowalska',
      email: 'zoe+test@example.com',
      repeatEmail: 'zoe+test@example.com',
      pesel: pesel,
      birthDate: birthDate,
    );

    test('is under the site from the app config, with or without its slash', () {
      expect(uri(site: 'https://ekp.test/').path, '/auth/register');
      expect(uri(site: 'https://ekp.test').path, '/auth/register');
      expect(uri(site: 'https://ekp.test').host, 'ekp.test');
    });

    test('is on the EKP site when the config is not there', () {
      expect(uri().host, 'ekp.mpk.krakow.pl');
      expect(uri(site: '').host, 'ekp.mpk.krakow.pl');
    });

    test('carries what was typed, readable on the other side', () {
      final query = uri(site: 'https://ekp.test/', pesel: '10261401356').queryParameters;
      expect(query['firstName'], 'Zoë');
      expect(query['email'], 'zoe+test@example.com');
      expect(query['isNoPesel'], 'false');
      expect(query['pesel'], '10261401356');
      expect(query.containsKey('birthDate'), isFalse);
    });

    test('says so without a PESEL, and gives the birth date as a day', () {
      final query = uri(site: 'https://ekp.test/', birthDate: DateTime(2012, 3, 5)).queryParameters;
      expect(query['isNoPesel'], 'true');
      expect(query.containsKey('pesel'), isFalse);
      expect(query['birthDate'], '2012-03-05');
    });
  });
}
