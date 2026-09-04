import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

import 'package:my_first_app/main.dart';
import 'package:my_first_app/providers/portfolio_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Contact screen fields send a real email through the live API',
      (WidgetTester tester) async {
    await dotenv.load(fileName: '.env');

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PortfolioProvider(),
        child: const PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

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
      'Integration test: submitted through the real Contact screen '
      'fields, end to end, on a real device with real networking.',
    );

    await tester.tap(find.text('Send Message'));

    const successText = 'Message sent successfully!';
    const errorText = 'Unable to send your message. Please try again.';
    var found = '';
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 500));
      if (find.text(successText).evaluate().isNotEmpty) {
        found = successText;
        break;
      }
      if (find.text(errorText).evaluate().isNotEmpty) {
        found = errorText;
        break;
      }
    }

    expect(
      found,
      successText,
      reason: found.isEmpty
          ? 'Neither success nor error snackbar appeared within 15s'
          : 'App showed: $found',
    );
  });
}
