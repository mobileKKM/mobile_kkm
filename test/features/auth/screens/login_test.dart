import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/auth/screens/login_screen.dart';
import 'package:mobile_kkm/features/auth/screens/register_screen.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';

const _loginReply = {
  'token': 'aaa.bbb.ccc',
  'refresh': 'feedfacefeedfacefeedfacefeedface',
  'expires': '2100-01-01T00:00:00Z',
};

Future<void> _signIn(WidgetTester tester) async {
  await tester.enterText(field('E-mail'), ' user@example.com ');
  await tester.enterText(field('Password'), 'Secret123');
  await tapVisible(tester, find.widgetWithText(FilledButton, 'Sign in'));
}

void main() {
  testWidgets('starts on the login screen when there is no session', (tester) async {
    await pumpApp(tester, FakeAdapter());
    expect(find.text('mobileKKM'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
  });

  testWidgets('starts on home when a session is stored', (tester) async {
    await pumpApp(tester, FakeAdapter(), session: signedInSession);
    expect(find.text('Sign out'), findsOneWidget);
  });

  group('an expired stored session', () {
    final expired = AuthSession(
      token: 'old.old.old',
      refresh: 'feedfacefeedfacefeedfacefeedface',
      expires: DateTime.utc(2020),
    );

    testWidgets('is renewed before opening home', (tester) async {
      final adapter = FakeAdapter()..reply('POST', '/auth/token/recover', 200, _loginReply);
      final app = await pumpApp(tester, adapter, session: expired);

      expect(find.text('Sign out'), findsOneWidget);
      expect((await app.client.session.currentSession())!.token, 'aaa.bbb.ccc');
    });

    testWidgets('returns to login when the server rejects it', (tester) async {
      final adapter = FakeAdapter()..reply('POST', '/auth/token/recover', 401);
      await pumpApp(tester, adapter, session: expired);

      expect(find.text('Your session has expired. Please sign in again.'), findsOneWidget);
    });

    testWidgets('is kept when the server is unreachable', (tester) async {
      final adapter = FakeAdapter()..fail('POST', '/auth/token/recover');
      final app = await pumpApp(tester, adapter, session: expired);

      expect(find.text('Sign out'), findsOneWidget);
      expect((await app.client.session.currentSession())!.token, 'old.old.old');
    });
  });

  testWidgets('successful login opens home', (tester) async {
    final adapter = FakeAdapter()..reply('POST', '/auth/login', 200, _loginReply);
    await pumpApp(tester, adapter);

    await _signIn(tester);

    expect(find.text('Sign out'), findsOneWidget);
    final body = adapter.requestTo('/auth/login').data as Map<String, dynamic>;
    expect(body['username'], 'user@example.com');
    expect(body['password'], 'Secret123');
  });

  testWidgets('wrong credentials show a localized error', (tester) async {
    final adapter = FakeAdapter()..reply('POST', '/auth/login', 401);
    await pumpApp(tester, adapter);

    await _signIn(tester);

    expect(find.text('Wrong e-mail or password.'), findsOneWidget);
    expect(find.text('Sign out'), findsNothing);
  });

  testWidgets('a dropped connection shows the network error', (tester) async {
    final adapter = FakeAdapter()..fail('POST', '/auth/login');
    await pumpApp(tester, adapter);

    await _signIn(tester);

    expect(find.textContaining('Could not reach the server'), findsOneWidget);
  });

  testWidgets('empty fields are rejected without a request', (tester) async {
    final adapter = FakeAdapter();
    await pumpApp(tester, adapter);

    await tapVisible(tester, find.widgetWithText(FilledButton, 'Sign in'));

    expect(find.text('This field is required'), findsNWidgets(2));
    expect(adapter.requests, isEmpty);
  });

  testWidgets('opening another screen runs a page transition', (tester) async {
    await pumpApp(tester, FakeAdapter());

    await tester.tap(find.text('Create account'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 80));

    // Mid-transition both screens are on stage; without one the login screen
    // would already be gone.
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(RegisterScreen), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('the keyboard covers the illustration, not the form', (tester) async {
    await pumpApp(tester, FakeAdapter());
    final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
    final skyline = find.byType(SvgPicture);
    final button = find.widgetWithText(FilledButton, 'Sign in');
    expect(tester.getRect(skyline).bottom, screen.height);
    expect(tester.getRect(button).bottom, lessThanOrEqualTo(tester.getRect(skyline).top));

    // A 300dp keyboard (the view is 3x).
    tester.view.viewInsets = const FakeViewPadding(bottom: 900);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    final keyboardTop = screen.height - 300;

    // The illustration has not moved: it now sits behind the keyboard.
    expect(tester.getRect(skyline).bottom, screen.height);
    expect(tester.getRect(skyline).top, greaterThanOrEqualTo(keyboardTop));
    // The form's viewport ends at the keyboard, so everything is reachable.
    expect(tester.getRect(find.byType(SingleChildScrollView)).bottom, keyboardTop);
    await tester.ensureVisible(button);
    await tester.pumpAndSettle();
    expect(tester.getRect(button).bottom, lessThanOrEqualTo(keyboardTop));
  });

  testWidgets('logout returns to login', (tester) async {
    final adapter = FakeAdapter()..reply('POST', '/auth/logout', 200);
    await pumpApp(tester, adapter, session: signedInSession);

    await tapVisible(tester, find.text('Sign out'));

    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
  });

  testWidgets('an expired session returns to login with a notice', (tester) async {
    final app = await pumpApp(tester, FakeAdapter(), session: signedInSession);

    await app.client.session.publishExpired();
    await tester.pumpAndSettle();

    expect(find.text('Your session has expired. Please sign in again.'), findsOneWidget);
  });
}
