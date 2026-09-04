import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:my_first_app/services/contact_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Direct ContactService call reports the real error',
      (WidgetTester tester) async {
    await dotenv.load(fileName: '.env');

    // ignore: avoid_print
    print('CONTACT_API_URL = "${dotenv.env['CONTACT_API_URL']}"');
    // ignore: avoid_print
    print('CONTACT_API_KEY = "${dotenv.env['CONTACT_API_KEY']}"');

    try {
      await ContactService.sendMessage(
        const ContactMessage(
          name: 'Tadele Mesfin',
          email: 'tonysolomon071@gmail.com',
          message: 'Direct service-call debug test.',
        ),
      );
      // ignore: avoid_print
      print('SUCCEEDED');
    } catch (e, st) {
      // ignore: avoid_print
      print('FAILED WITH: ${e.runtimeType}: $e');
      // ignore: avoid_print
      print(st);
    }
  });
}
