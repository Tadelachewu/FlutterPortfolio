import 'dart:convert';

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

/// Sends contact messages to the configured backend.
///
/// The destination email (`tade2024bdugit@gmail.com`) must be configured on
/// the backend; the visitor's email is only the sender's contact info and is
/// never treated as the destination.
class ContactService {
  /// Set this to your backend endpoint, e.g. `https://api.example.com/contact`.
  ///
  /// Sending is disabled until a real endpoint is configured, so the app
  /// never pretends a message was delivered.
  static const String _apiEndpoint = '';

  /// Sends [message] to the contact backend.
  ///
  /// Throws if no backend is configured or the request fails, so the caller
  /// can surface a user-friendly error.
  static Future<void> sendMessage(ContactMessage message) async {
    if (_apiEndpoint.isEmpty) {
      throw UnimplementedError(
        'Contact backend is not configured yet. '
        'Set ContactService._apiEndpoint.',
      );
    }

    final response = await http.post(
      Uri.parse(_apiEndpoint),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': message.name,
        'email': message.email,
        'message': message.message,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(
        'Contact request failed with status ${response.statusCode}',
      );
    }
  }
}