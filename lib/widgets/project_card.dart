import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (project.isFeatured)
                  Chip(
                    label: const Text('Featured'),
                    visualDensity: VisualDensity.compact,
                    avatar: const Icon(Icons.star, size: 16),
                    backgroundColor: theme.colorScheme.tertiaryContainer,
                    labelStyle: TextStyle(
                      color: theme.colorScheme.onTertiaryContainer,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies
                  .map(
                    (tech) => Chip(
                      label: Text(tech),
                      visualDensity: VisualDensity.compact,
                      labelStyle: theme.textTheme.labelMedium,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (project.githubUrl != null) ...[
                  ActionChip(
                    avatar: const Icon(Icons.code, size: 18),
                    label: const Text('GitHub'),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
                if (project.liveUrl != null) ...[
                  ActionChip(
                    avatar: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Live Demo'),
                    onPressed: () {},
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}