import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/main.dart';
import 'package:my_first_app/providers/portfolio_provider.dart';

void main() {
  testWidgets('Contact screen fields send a real email through the live API',
      (WidgetTester tester) async {
    await dotenv.load(fileName: '.env');

    tester.view.physicalSize = const Size(1080, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PortfolioProvider(),
        child: const PortfolioApp(),
      ),
    );

    await tester.tap(find.text('Contact').last, warnIfMissed: false);
    await tester.pumpAndSettle();

    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Send Message'),
      300,
      scrollable: scrollable,
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your name'),
      'Tadele Mesfin',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your email'),
      'tonysolomon071@gmail.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Message'),
      'Smoke test: submitted through the real Contact screen fields, '
      'end to end.',
    );

    await tester.tap(find.text('Send Message'));
    await tester.pumpAndSettle(const Duration(seconds: 8));

    expect(find.text('Message sent successfully!'), findsOneWidget);
  });
}
