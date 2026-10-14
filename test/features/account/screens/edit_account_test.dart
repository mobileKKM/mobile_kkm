import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/features/account/widgets/photo_preview.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _userData = '/account/user-data';
const _photo = '/account/photo';

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', _userData, 200, userDataJson(address: addressJson, phone: '600123456'))
  ..reply('POST', _userData, 204)
  ..reply('POST', _photo, 200, {'code': null, 'message': null});

Future<App> _open(WidgetTester tester, FakeAdapter adapter, {FakePhotoPicker? photoPicker}) async {
  // Tall: the form is longer than a phone, and the tests look at all of it.
  final app = await pumpApp(tester, adapter, session: signedInSession, photoPicker: photoPicker, tall: true);
  await openTab(tester, 'Account');
  await tapVisible(tester, find.widgetWithText(GroupRow, 'Edit account'));
  return app;
}

final _save = find.widgetWithText(FilledButton, 'Save changes');
final _changePhoto = find.widgetWithText(FilledButton, 'Change photo');

bool _enabled(WidgetTester tester, Finder button) => tester.widget<FilledButton>(button).onPressed != null;

void main() {
  testWidgets('opens with what the account has, and nothing to save', (tester) async {
    await _open(tester, _adapter());

    expect(find.widgetWithText(TextFormField, 'Jan'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '600123456'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'ul. Testowa'), findsOneWidget);
    // What cannot be changed is text.
    expect(find.text('jan@example.com'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'jan@example.com'), findsNothing);
    expect(_enabled(tester, _save), isFalse);
  });

  testWidgets('a change is saved in one request, and the account is loaded again', (tester) async {
    final adapter = _adapter();
    final app = await _open(tester, adapter);
    final loads = adapter.requests.where((request) => request.method == 'GET' && request.path.endsWith(_userData));
    final before = loads.length;

    await tester.enterText(field('Phone number'), '600123457');
    await tester.pump();
    expect(_enabled(tester, _save), isTrue);
    await tapVisible(tester, _save);

    final sent = adapter.requests.singleWhere(
      (request) => request.method == 'POST' && request.path.endsWith(_userData),
    );
    expect(sent.data, {
      'phoneNumber': '600123457',
      'firstName': 'Jan',
      'lastName': 'Testowy',
      'registeredAddress': addressJson,
    });
    expect(loads.length, before + 1);
    expect(find.text('Your details were updated.'), findsOneWidget);
    // Still here, with nothing left to save.
    expect(app.location, Routes.accountEdit);
    expect(_enabled(tester, _save), isFalse);
  });

  testWidgets('a flat that was taken out is sent empty, as the official client does', (tester) async {
    final adapter = _adapter();
    await _open(tester, adapter);

    await tester.enterText(field('Flat'), '');
    await tester.pump();
    await tapVisible(tester, _save);

    final sent = adapter.requests.singleWhere(
      (request) => request.method == 'POST' && request.path.endsWith(_userData),
    );
    final address = (sent.data as Map<String, dynamic>)['registeredAddress'] as Map<String, dynamic>;
    expect(address['apartmentNumber'], '');
    expect(find.text('This field is required'), findsNothing);
  });

  testWidgets('what is missing is said when Save is tapped, and nothing is sent', (tester) async {
    final adapter = _adapter();
    await _open(tester, adapter);

    await tester.enterText(field('Building'), '');
    await tester.enterText(field('Postcode'), '31');
    await tester.pump();
    expect(find.text('This field is required'), findsNothing);
    await tapVisible(tester, _save);

    expect(find.text('This field is required'), findsOneWidget);
    expect(find.text('Use the form 00-000'), findsOneWidget);
    expect(adapter.requests.where((request) => request.method == 'POST'), isEmpty);
  });

  testWidgets('a refusal is the server\'s message on top, with the fields as typed', (tester) async {
    const reason = 'Nieprawidłowy numer telefonu.';
    final adapter = _adapter()..reply('POST', _userData, 400, {'code': 'error', 'message': reason});
    await _open(tester, adapter);

    await tester.enterText(field('Phone number'), '60012345');
    await tester.pump();
    await tapVisible(tester, _save);

    expect(find.widgetWithText(MessageBanner, reason), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '60012345'), findsOneWidget);
    expect(_enabled(tester, _save), isTrue);
  });

  testWidgets('leaving with unsaved changes asks first', (tester) async {
    final app = await _open(tester, _adapter());
    await tester.enterText(field('First name'), 'Janusz');
    await tester.pump();

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Discard changes?'), findsOneWidget);
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.accountEdit);
    expect(find.widgetWithText(TextFormField, 'Janusz'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Discard'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.account);
  });

  testWidgets('leaving without changes asks nothing', (tester) async {
    final app = await _open(tester, _adapter());

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Discard changes?'), findsNothing);
    expect(app.location, Routes.account);
  });

  testWidgets('offline, what was typed stays and nothing can be saved', (tester) async {
    final adapter = _adapter()..fail('GET', '/service-status');
    await _open(tester, adapter);

    await tester.enterText(field('Phone number'), '600123457');
    await tester.pump();

    expect(find.textContaining('Your changes are kept; connect to save them.', findRichText: true), findsOneWidget);
    expect(_enabled(tester, _save), isFalse);
    expect(_enabled(tester, _changePhoto), isFalse);
    expect(find.widgetWithText(TextFormField, '600123457'), findsOneWidget);
  });

  group('the photo', () {
    testWidgets('is saved by itself, under the picture', (tester) async {
      final adapter = _adapter();
      final picker = FakePhotoPicker(onePixelPng);
      await _open(tester, adapter, photoPicker: picker);

      await tapVisible(tester, _changePhoto);
      expect(find.text('Profile photo'), findsOneWidget);
      await tester.tap(find.text('Choose from gallery'));
      await tester.pumpAndSettle();

      expect(find.text('New photo, not saved yet'), findsOneWidget);
      // The form's own Save has nothing to do with it.
      expect(_enabled(tester, _save), isFalse);
      expect(adapter.requestsTo(_photo), isEmpty);

      await tapVisible(tester, find.widgetWithText(FilledButton, 'Save photo'));

      expect(adapter.requestTo(_photo).method, 'POST');
      expect(find.text('Your photo was changed.'), findsOneWidget);
      expect(find.text('New photo, not saved yet'), findsNothing);
      expect(
        adapter.requests.where((request) => request.method == 'POST' && request.path.endsWith(_userData)),
        isEmpty,
      );
    });

    testWidgets('moves nothing under it when picked or saved', (tester) async {
      await _open(tester, _adapter(), photoPicker: FakePhotoPicker(onePixelPng));
      final preview = find.byType(PhotoPreview);
      Rect where() => tester.getRect(preview);
      // The test font is wide: the captions and buttons under the photo wrap
      // differently here, so it is where they begin that has to stay.
      double captionTop(String caption) => tester.getTopLeft(find.text(caption)).dy;
      double formTop() => tester.getTopLeft(find.text('Personal details')).dy;
      final photo = where();
      final caption = captionTop('JPG, PNG or WebP, up to 5 MB');
      final form = formTop();

      await tapVisible(tester, _changePhoto);
      await tester.tap(find.text('Choose from gallery'));
      await tester.pumpAndSettle();
      expect(tester.widget<PhotoPreview>(preview).pending, isTrue);
      expect(where(), photo);
      expect(captionTop('New photo, not saved yet'), caption);

      await tapVisible(tester, find.widgetWithText(FilledButton, 'Save photo'));
      expect(where(), photo);
      expect(formTop(), form);
      // The saved photo stays, rather than the initials while the account's
      // picture loads again.
      final saved = tester.widget<PhotoPreview>(preview);
      expect(saved.pending, isFalse);
      expect(saved.bytes, onePixelPng);
    });

    testWidgets('can be dropped again before it is saved', (tester) async {
      final adapter = _adapter();
      await _open(tester, adapter, photoPicker: FakePhotoPicker(onePixelPng));

      await tapVisible(tester, _changePhoto);
      await tester.tap(find.text('Take a photo'));
      await tester.pumpAndSettle();
      await tapVisible(tester, find.widgetWithText(TextButton, 'Cancel'));

      expect(find.text('New photo, not saved yet'), findsNothing);
      expect(_changePhoto, findsOneWidget);
      expect(adapter.requestsTo(_photo), isEmpty);
    });

    testWidgets('that the server would not take is refused here', (tester) async {
      final picker = FakePhotoPicker(Uint8List.fromList('GIF89a'.codeUnits));
      await _open(tester, _adapter(), photoPicker: picker);

      await tapVisible(tester, _changePhoto);
      await tester.tap(find.text('Choose from gallery'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(MessageBanner, 'Use a JPG, PNG or WebP photo.'), findsOneWidget);
      expect(find.text('New photo, not saved yet'), findsNothing);
    });
  });
}
