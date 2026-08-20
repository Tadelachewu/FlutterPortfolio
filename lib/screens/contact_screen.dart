import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/portfolio_provider.dart';
import '../services/contact_service.dart';
import '../services/url_launcher_service.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isSending = true);

    try {
      await ContactService.sendMessage(
        ContactMessage(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          message: _messageController.text.trim(),
        ),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );
      _formKey.currentState?.reset();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to send your message. Please try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final portfolio = context.watch<PortfolioProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 8),
            Text(
              'Contact Me',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'I would love to hear from you. Reach out through any of '
              'the channels below.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            _ContactCard(
              icon: Icons.email,
              label: 'Email',
              value: portfolio.email,
              onTap: () => openUrl(
                'mailto:${portfolio.email}?subject=Hello%20Tadele',
                context,
              ),
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.phone,
              label: 'Phone',
              value: portfolio.phone,
              onTap: () => openUrl('tel:${portfolio.phone}', context),
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.location_on,
              label: 'Location',
              value: portfolio.location,
              onTap: () => openUrl(
                'https://www.google.com/maps/search/?api=1&query='
                'Addis+Ababa,+Ethiopia',
                context,
              ),
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.code,
              label: 'GitHub',
              value: portfolio.githubUsername,
              onTap: () => openUrl(portfolio.githubUrl, context),
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.send,
              label: 'Telegram',
              value: '@${portfolio.telegramUsername}',
              onTap: () => openUrl(portfolio.telegramUrl, context),
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.business,
              label: 'LinkedIn',
              value: '@${portfolio.linkedinUsername}',
              onTap: () => openUrl(portfolio.linkedinUrl, context),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Send a message',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Your name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Your email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) {
                            return 'Please enter a valid email address';
                          }
                          final isValid = RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(email);
                          if (!isValid) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _messageController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.message_outlined),
                        ),
                        validator: (value) {
                          final message = value?.trim() ?? '';
                          if (message.isEmpty) {
                            return 'Please enter your message';
                          }
                          if (message.length < 10) {
                            return 'Your message must be at least 10 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _isSending ? null : _submit,
                          icon: _isSending
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send),
                          label: Text(
                            _isSending ? 'Sending...' : 'Send Message',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            foregroundColor: theme.colorScheme.onPrimaryContainer,
            child: Icon(icon),
          ),
          title: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          subtitle: Text(value),
        ),
      ),
    );
  }
}