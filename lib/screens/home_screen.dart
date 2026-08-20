import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/portfolio_provider.dart';
import '../router/app_router.dart';
import '../widgets/section_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolio = context.watch<PortfolioProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 16),
            Center(
              child: CircleAvatar(
                radius: 56,
                backgroundColor: theme.colorScheme.primaryContainer,
                backgroundImage: const AssetImage('assets/tade.JPG'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              portfolio.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              portfolio.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              portfolio.bio,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '${portfolio.projects.length}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Projects', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '${portfolio.education.length}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Education',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Explore',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SectionCard(
              icon: Icons.code,
              title: 'My Projects',
              subtitle: 'See what I have built',
              onTap: () => context.go(AppRouter.projectsPath),
            ),
            const SizedBox(height: 12),
            SectionCard(
              icon: Icons.school,
              title: 'Educational Background',
              subtitle: 'My academic journey',
              onTap: () => context.go(AppRouter.educationPath),
            ),
            const SizedBox(height: 12),
            SectionCard(
              icon: Icons.mail,
              title: 'Contact Me',
              subtitle: 'Let\'s work together',
              onTap: () => context.go(AppRouter.contactPath),
            ),
          ],
        ),
      ),
    );
  }
}