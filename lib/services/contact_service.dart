import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A contact message submitted through the contact form.
class ContactMessage {
  final String name;
  final String email;
  final String message;

  const ContactMessage({
    required this.name,
    required this.email,
    required this.message,
  });
}

/// Sends contact messages to [tade2024bdugit@gmail.com] via EmailJS.
///
/// Credentials are read from environment variables (`.env` file):
///   EMAILJS_SERVICE_ID, EMAILJS_TEMPLATE_ID, EMAILJS_PUBLIC_KEY,
///   EMAILJS_PRIVATE_KEY
///
/// The visitor's email is only the sender's contact info — the destination
/// address is configured in your EmailJS template, not in the app.
class ContactService {
  static String _value(String key) => dotenv.env[key]?.trim() ?? '';

  static Future<void> sendMessage(ContactMessage message) async {
    final serviceId = _value('EMAILJS_SERVICE_ID');
    final templateId = _value('EMAILJS_TEMPLATE_ID');
    final publicKey = _value('EMAILJS_PUBLIC_KEY');
    final privateKey = _value('EMAILJS_PRIVATE_KEY');

    if (serviceId.isEmpty || templateId.isEmpty || publicKey.isEmpty) {
      throw StateError(
        'EmailJS is not configured. '
        'Fill in EMAILJS_SERVICE_ID, EMAILJS_TEMPLATE_ID and '
        'EMAILJS_PUBLIC_KEY in the .env file.',
      );
    }

    await emailjs.send(
      serviceId,
      templateId,
      {
        'name': message.name,
        'email': message.email,
        'message': message.message,
      },
      emailjs.Options(
        publicKey: publicKey,
        privateKey: privateKey.isEmpty ? null : privateKey,
      ),
    );
  }
}