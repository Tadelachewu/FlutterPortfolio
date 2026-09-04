import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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

/// Sends contact messages to the Email Sender API.
///
/// The endpoint URL and API key are read from the `.env` file
/// (`CONTACT_API_URL`, `CONTACT_API_KEY`). The API key is omitted from the
/// request when left blank.
class ContactService {
  static Future<void> sendMessage(ContactMessage message) async {
    final endpoint = dotenv.env['CONTACT_API_URL']?.trim() ?? '';
    final apiKey = dotenv.env['CONTACT_API_KEY']?.trim() ?? '';

    if (endpoint.isEmpty) {
      throw StateError(
        'CONTACT_API_URL is not configured. Set it in the .env file.',
      );
    }

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        if (apiKey.isNotEmpty) 'x-api-key': apiKey,
      },
      body: jsonEncode({
        'name': message.name,
        'email': message.email,
        'message': message.message,
      }),
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (data['success'] != true) {
      throw StateError(
        data['message']?.toString() ?? 'Failed to send message.',
      );
    }
  }
}
