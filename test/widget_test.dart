import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/main.dart';
import 'package:my_first_app/providers/portfolio_provider.dart';

Widget _buildApp() {
  return ChangeNotifierProvider(
    create: (_) => PortfolioProvider(),
    child: const PortfolioApp(),
  );
}

Future<void> _pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1080, 3000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(_buildApp());
}

final _listScrollable = find.byType(Scrollable).first;

Future<void> _openContactTab(WidgetTester tester) async {
  await tester.tap(find.text('Contact').last, warnIfMissed: false);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Shows Home screen with navigation', (WidgetTester tester) async {
    await _pumpApp(tester);

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Your Name'), findsOneWidget);
    expect(find.text('Projects'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Explore'),
      200,
      scrollable: _listScrollable,
    );
    expect(find.text('Explore'), findsOneWidget);
  });

  testWidgets('Navigates to Projects tab', (WidgetTester tester) async {
    await _pumpApp(tester);

    await tester.tap(find.text('Projects').last);
    await tester.pumpAndSettle();

    expect(find.text('My Projects'), findsOneWidget);
  });

  testWidgets('Toggles dark mode', (WidgetTester tester) async {
    await _pumpApp(tester);

    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
  });

  testWidgets('Contact form validates empty submission', (WidgetTester tester) async {
    await _pumpApp(tester);
    await _openContactTab(tester);

    await tester.scrollUntilVisible(
      find.text('Send Message'),
      300,
      scrollable: _listScrollable,
    );
    await tester.tap(find.text('Send Message'));
    await tester.pump();

    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter a valid email address'), findsOneWidget);
    expect(find.text('Please enter your message'), findsOneWidget);
  });

  testWidgets('Contact form shows error when emailjs is not configured',
      (WidgetTester tester) async {
    await _pumpApp(tester);
    await _openContactTab(tester);

    await tester.scrollUntilVisible(
      find.text('Send Message'),
      300,
      scrollable: _listScrollable,
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your name'),
      'Tadele',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your email'),
      'tade2024bdugit@gmail.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Message'),
      'This is a valid test message that is long enough.',
    );
    await tester.tap(find.text('Send Message'));
    await tester.pumpAndSettle();

    expect(
      find.text('Unable to send your message. Please try again.'),
      findsOneWidget,
    );
  });
}