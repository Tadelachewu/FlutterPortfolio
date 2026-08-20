import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in the device's default app for the scheme, or a browser.
///
/// Shows a SnackBar instead of crashing when the URL is invalid or
/// cannot be launched.
Future<void> openUrl(String url, BuildContext context) async {
  final uri = Uri.tryParse(url);
  if (uri == null) {
    _showError(context);
    return;
  }

  final canLaunch = await canLaunchUrl(uri);
  if (!canLaunch) {
    if (context.mounted) _showError(context);
    return;
  }

  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    if (context.mounted) _showError(context);
  }
}

void _showError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Unable to open this link.')),
  );
}