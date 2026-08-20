import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/portfolio_provider.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

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
              'My Projects',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'A selection of things I have built.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            ...portfolio.projects.map(
              (project) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ProjectCard(project: project),
              ),
            ),
          ],
        ),
      ),
    );
  }
}