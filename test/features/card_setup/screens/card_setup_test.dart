import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/platform/photo_picker.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _userData = '/account/user-data';
const _photo = '/account/photo';
const _createMkkm = '/storage-medium/create-mkkm';
const _create = '/storage-medium/create';

/// An account as it is after registration: no card, no address, no photo.
FakeAdapter _newAccount({Map<String, dynamic>? address, String? photoUrl}) => FakeAdapter()
  ..reply('GET', _userData, 200, userDataJson(card: false, address: address, photoUrl: photoUrl))
  ..reply('POST', _photo, 200, {'code': null, 'message': null})
  ..reply('POST', _createMkkm, 200);

/// The server has made the card: the next look at the user data finds it.
void _cardArrives(FakeAdapter adapter) => adapter.reply('GET', _userData, 200, userDataJson());

Finder _button(String label) => find.widgetWithText(FilledButton, label);

bool _enabled(WidgetTester tester, Finder button) => tester.widget<ButtonStyleButton>(button).onPressed != null;

Future<void> _fillAddress(WidgetTester tester) async {
  await tester.enterText(field('Street'), 'ul. Testowa');
  await tester.enterText(field('Building'), '1');
  await tester.enterText(field('Postcode'), '00001');
  await tester.enterText(field('Town'), 'Kraków');
  await tester.pumpAndSettle();
}

/// From the welcome to step 2, with the address typed in.
Future<void> _toPhotoStep(WidgetTester tester) async {
  await tapVisible(tester, _button('Create mKKM card'));
  await _fillAddress(tester);
  await tapVisible(tester, _button('Continue'));
}

Future<void> _pickFromGallery(WidgetTester tester, {String button = 'Add photo'}) async {
  await tapVisible(tester, find.text(button));
  await tester.tap(find.text('Choose from gallery'));
  await tester.pumpAndSettle();
}

/// Taps without waiting for the screen to come to rest: a busy button
/// never does.
Future<void> _tapAndWait(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  group('the gate', () {
    testWidgets('an account without a card gets the welcome instead of the app', (tester) async {
      final app = await pumpApp(tester, _newAccount(), session: signedInSession);

      expect(app.location, '/card-setup');
      expect(find.text('Set up your mKKM card'), findsOneWidget);
      expect(find.textContaining('Hi Jan!'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      // There is no way round it.
      app.router.go('/tickets');
      await tester.pumpAndSettle();
      expect(app.location, '/card-setup');
    });

    testWidgets('an account with a card never sees it', (tester) async {
      final adapter = FakeAdapter()..reply('GET', _userData, 200, userDataJson());
      final app = await pumpApp(tester, adapter, session: signedInSession);

      expect(app.location, '/home');
      app.router.go('/card-setup');
      await tester.pumpAndSettle();
      expect(app.location, '/home');
    });

    testWidgets('user data that cannot be loaded signs the user out on this device', (tester) async {
      final adapter = FakeAdapter()..fail('GET', _userData);
      final app = await pumpApp(tester, adapter, session: signedInSession);

      expect(app.location, '/login');
      expect(find.textContaining('account details couldn’t be loaded'), findsOneWidget);
      expect(await app.client.session.currentSession(), isNull);
      // The server is not asked: it may be the one that does not answer.
      expect(adapter.requestsTo('/auth/logout'), isEmpty);
    });

    testWidgets('a start without stored user data waits for it on the splash, then signs out', (tester) async {
      final adapter = FakeAdapter()..hold('GET', _userData);
      final app = await pumpApp(tester, adapter, session: signedInSession, settle: false);
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }
      expect(app.location, '/');
      expect(find.text('Loading your account…'), findsNothing);

      await tester.pump(const Duration(seconds: 3));
      expect(app.location, '/');
      expect(find.text('Loading your account…'), findsOneWidget);

      await tester.pump(const Duration(seconds: 8));
      await tester.pumpAndSettle();
      expect(app.location, '/login');
      expect(find.textContaining('account details couldn’t be loaded'), findsOneWidget);
      expect(await app.client.session.currentSession(), isNull);
      expect(adapter.requestsTo('/auth/logout'), isEmpty);
    });

    testWidgets('a stored copy keeps the app open when the server does not answer', (tester) async {
      final adapter = FakeAdapter()..fail('GET', _userData);
      final cache = InMemoryUserDataCache(UserDataResponse.fromJson(userDataJson()));
      final app = await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

      expect(app.location, '/home');
    });

    testWidgets('signing out is the one way past it', (tester) async {
      final app = await pumpApp(tester, _newAccount(), session: signedInSession);

      await tapVisible(tester, find.widgetWithText(TextButton, 'Sign out'));
      await tester.tap(_button('Sign out'));
      await tester.pumpAndSettle();
      expect(app.location, '/login');
    });
  });

  group('step 1, the address', () {
    testWidgets('says what is missing on the tap, not before', (tester) async {
      final app = await pumpApp(tester, _newAccount(), session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));

      expect(app.location, '/card-setup/address');
      expect(find.text('Step 1 of 2 · Home address'), findsOneWidget);
      expect(_enabled(tester, _button('Continue')), isFalse);

      await tester.enterText(field('Street'), 'ul. Testowa');
      await tester.pumpAndSettle();
      expect(find.text('This field is required'), findsNothing);

      await tapVisible(tester, _button('Continue'));
      expect(find.text('This field is required'), findsNWidgets(3));
      expect(app.location, '/card-setup/address');
    });

    testWidgets('the postcode takes the form 00-000', (tester) async {
      await pumpApp(tester, _newAccount(), session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));

      await tester.enterText(field('Postcode'), '3055a27');
      expect(find.text('30-552'), findsOneWidget);

      await tester.enterText(field('Postcode'), '305');
      await tester.enterText(field('Street'), 'ul. Testowa');
      await tester.enterText(field('Building'), '1');
      await tester.enterText(field('Town'), 'Kraków');
      await tester.pumpAndSettle();
      await tapVisible(tester, _button('Continue'));
      expect(find.text('Use the form 00-000'), findsOneWidget);
    });

    testWidgets('is filled in from the account, and can be changed', (tester) async {
      final app = await pumpApp(tester, _newAccount(address: addressJson), session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));

      expect(find.text('ul. Testowa'), findsOneWidget);
      expect(find.text('00-001'), findsOneWidget);
      expect(find.text('41'), findsOneWidget);
      expect(_enabled(tester, _button('Continue')), isTrue);

      await tapVisible(tester, _button('Continue'));
      expect(app.location, '/card-setup/address/photo');

      // Back keeps what was there.
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(app.location, '/card-setup/address');
      expect(find.text('ul. Testowa'), findsOneWidget);
    });

    testWidgets('offers the streets of Kraków once typing stops', (tester) async {
      final adapter = _newAccount()
        ..reply('GET', '/account/street-autocomplete/15/Flor', 200, {
          'streets': ['FLORIAŃSKA', 'FLORIANA STRASZEWSKIEGO'],
          'code': null,
          'message': null,
        });
      await pumpApp(tester, adapter, session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));

      await tester.enterText(field('Street'), 'Flor');
      await tester.pump(const Duration(milliseconds: 400));
      expect(adapter.requestsTo('/account/street-autocomplete/15/Flor'), isEmpty);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      expect(find.text('FLORIAŃSKA'), findsOneWidget);

      await tester.tap(find.text('FLORIANA STRASZEWSKIEGO'));
      await tester.pumpAndSettle();
      expect(tester.widget<TextFormField>(field('Street')).controller?.text, 'FLORIANA STRASZEWSKIEGO');
      expect(find.text('FLORIAŃSKA'), findsNothing);
    });

    testWidgets('offers none for another town', (tester) async {
      final adapter = _newAccount();
      await pumpApp(tester, adapter, session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));

      await tester.enterText(field('Town'), 'Wieliczka');
      await tester.enterText(field('Street'), 'Flor');
      await tester.pump(const Duration(seconds: 1));
      expect(adapter.requests.where((request) => request.path.contains('street-autocomplete')), isEmpty);
    });
  });

  group('step 2, the photo', () {
    testWidgets('the card can only be asked for with a photo', (tester) async {
      final picker = FakePhotoPicker(onePixelPng);
      final app = await pumpApp(tester, _newAccount(), session: signedInSession, photoPicker: picker);
      await _toPhotoStep(tester);

      expect(app.location, '/card-setup/address/photo');
      expect(find.text('Step 2 of 2 · Photo'), findsOneWidget);
      expect(_enabled(tester, _button('Create card')), isFalse);

      await tapVisible(tester, find.text('Add photo'));
      await tester.tap(find.text('Take a photo'));
      await tester.pumpAndSettle();
      expect(picker.sources, [PhotoSource.camera]);
      expect(find.text('New photo'), findsOneWidget);
      expect(find.text('Change photo'), findsOneWidget);
      expect(_enabled(tester, _button('Create card')), isTrue);
    });

    testWidgets('backing out of the camera changes nothing', (tester) async {
      await pumpApp(tester, _newAccount(), session: signedInSession, photoPicker: FakePhotoPicker());
      await _toPhotoStep(tester);

      await _pickFromGallery(tester);
      expect(find.text('Add photo'), findsOneWidget);
      expect(_enabled(tester, _button('Create card')), isFalse);
    });

    testWidgets('a file that is no JPG, PNG or WebP is refused', (tester) async {
      final picker = FakePhotoPicker(Uint8List.fromList('GIF89a'.codeUnits));
      await pumpApp(tester, _newAccount(), session: signedInSession, photoPicker: picker);
      await _toPhotoStep(tester);

      await _pickFromGallery(tester);
      expect(find.text('Use a JPG, PNG or WebP photo.'), findsOneWidget);
      expect(_enabled(tester, _button('Create card')), isFalse);
    });

    testWidgets('a photo of more than 5 MB is refused', (tester) async {
      final large = Uint8List(5 * 1024 * 1024 + 1)..setAll(0, [0xFF, 0xD8, 0xFF]);
      await pumpApp(tester, _newAccount(), session: signedInSession, photoPicker: FakePhotoPicker(large));
      await _toPhotoStep(tester);

      await _pickFromGallery(tester);
      expect(find.text('The photo is larger than 5 MB. Choose a smaller one.'), findsOneWidget);
      expect(_enabled(tester, _button('Create card')), isFalse);
    });
  });

  group('creating the card', () {
    testWidgets('sends the photo, then the address, and finds the card at once', (tester) async {
      final adapter = _newAccount();
      final photos = FakePhotoCache();
      final app = await pumpApp(
        tester,
        adapter,
        session: signedInSession,
        photoPicker: FakePhotoPicker(onePixelPng),
        photoCache: photos,
      );
      await _toPhotoStep(tester);
      await _pickFromGallery(tester);

      _cardArrives(adapter);
      await tapVisible(tester, _button('Create card'));

      final sent = adapter.requests.where((request) => request.method == 'POST').map((request) => request.path);
      expect(sent.map((path) => path.split('/api/v1').last), [_photo, _createMkkm]);
      final upload = (adapter.requestTo(_photo).data as FormData).files.single;
      expect(upload.key, 'photo');
      expect(upload.value.contentType?.mimeType, 'image/png');
      expect(adapter.requestTo(_createMkkm).data, {
        'city': 'Kraków',
        'postalCode': '00-001',
        'street': 'ul. Testowa',
        'buildingNumber': '1',
        'apartmentNumber': null,
      });
      // The new picture may come under the old one's address.
      expect(photos.cleared, 1);

      expect(app.location, '/card-setup');
      expect(find.text('Your mKKM card is ready'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('100001'), findsOneWidget);

      await tapVisible(tester, _button('Go to Home'));
      expect(app.location, '/home');
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('keeps the photo the account has', (tester) async {
      final adapter = _newAccount(address: addressJson, photoUrl: 'https://ekp.test/photo.jpg');
      final app = await pumpApp(tester, adapter, session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));
      await tapVisible(tester, _button('Continue'));

      expect(find.text('Change photo'), findsOneWidget);
      _cardArrives(adapter);
      await tapVisible(tester, _button('Create card'));

      expect(adapter.requestsTo(_photo), isEmpty);
      expect(adapter.requestTo(_createMkkm).data, addressJson);
      expect(app.location, '/card-setup');
      expect(find.text('Your mKKM card is ready'), findsOneWidget);
    });

    testWidgets('a refused address leads back to step 1 with the server\'s message', (tester) async {
      final adapter = _newAccount(address: addressJson, photoUrl: 'https://ekp.test/photo.jpg')
        ..reply('POST', _createMkkm, 400, {'code': 1, 'message': 'Kod pocztowy nie pasuje do miejscowości.'});
      final app = await pumpApp(tester, adapter, session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));
      await tapVisible(tester, _button('Continue'));
      await tapVisible(tester, _button('Create card'));

      expect(app.location, '/card-setup/address');
      expect(find.text('Kod pocztowy nie pasuje do miejscowości.'), findsOneWidget);

      // Trying again sends no second photo and drops the message.
      await tapVisible(tester, _button('Continue'));
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Kod pocztowy nie pasuje do miejscowości.'), findsNothing);
    });

    testWidgets('a failed upload stays on step 2', (tester) async {
      final adapter = _newAccount()..fail('POST', _photo);
      final app = await pumpApp(tester, adapter, session: signedInSession, photoPicker: FakePhotoPicker(onePixelPng));
      await _toPhotoStep(tester);
      await _pickFromGallery(tester);
      await tapVisible(tester, _button('Create card'));

      expect(app.location, '/card-setup/address/photo');
      expect(find.textContaining('connection'), findsOneWidget);
      expect(adapter.requestsTo(_createMkkm), isEmpty);
      expect(_enabled(tester, _button('Create card')), isTrue);
    });

    testWidgets('a card that takes its time is looked for every 3 s, the button busy meanwhile', (tester) async {
      final adapter = _newAccount(address: addressJson, photoUrl: 'https://ekp.test/photo.jpg');
      final app = await pumpApp(tester, adapter, session: signedInSession);
      await tapVisible(tester, _button('Create mKKM card'));
      await tapVisible(tester, _button('Continue'));
      final before = adapter.requestsTo(_userData).length;

      await _tapAndWait(tester, find.text('Create card'));
      // Looked at once; the step stays, its button busy.
      expect(adapter.requestsTo(_userData), hasLength(before + 1));
      expect(app.location, '/card-setup/address/photo');
      expect(find.text('Creating…'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(seconds: 3));
      expect(adapter.requestsTo(_userData), hasLength(before + 3));
      expect(app.location, '/card-setup/address/photo');

      // However long it takes.
      await tester.pump(const Duration(seconds: 60));
      expect(app.location, '/card-setup/address/photo');
      expect(find.text('Creating…'), findsOneWidget);

      _cardArrives(adapter);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(find.text('Your mKKM card is ready'), findsOneWidget);

      // No more looking once it is there.
      final after = adapter.requestsTo(_userData).length;
      await tester.pump(const Duration(seconds: 10));
      expect(adapter.requestsTo(_userData), hasLength(after));
    });
  });

  group('a detached card', () {
    FakeAdapter detached() => FakeAdapter()
      ..reply('GET', _userData, 200, userDataJson(detached: true))
      ..reply('POST', _create, 200);

    testWidgets('is shown with its customer code, and attached again by it', (tester) async {
      final adapter = detached();
      final app = await pumpApp(tester, adapter, session: signedInSession);

      expect(app.location, '/card-setup');
      expect(find.text('Add your mKKM card again'), findsOneWidget);
      expect(find.text('Detached'), findsOneWidget);
      expect(find.text('100001'), findsOneWidget);

      _cardArrives(adapter);
      await tapVisible(tester, _button('Add mKKM card'));

      expect(adapter.requestTo(_create).data, {
        'customerCode': '100001',
        'cityCardCode': 8,
        'universityId': null,
        // The sample account has no PESEL number.
        'isWithoutPesel': true,
      });
      expect(find.text('Your mKKM card is ready'), findsOneWidget);

      await tapVisible(tester, _button('Go to Home'));
      expect(app.location, '/home');
    });

    testWidgets('a refusal is shown in the server\'s words', (tester) async {
      final adapter = detached()..reply('POST', _create, 400, {'code': 1, 'message': 'Karta jest zablokowana.'});
      final app = await pumpApp(tester, adapter, session: signedInSession);

      await tapVisible(tester, _button('Add mKKM card'));
      expect(find.text('Karta jest zablokowana.'), findsOneWidget);
      expect(app.location, '/card-setup');
      expect(_enabled(tester, _button('Add mKKM card')), isTrue);
    });
  });
}
