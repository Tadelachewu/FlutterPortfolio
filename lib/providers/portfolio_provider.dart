import 'package:flutter/foundation.dart';

import '../models/education.dart';
import '../models/project.dart';

class PortfolioProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  int _selectedIndex = 0;

  bool get isDarkMode => _isDarkMode;
  int get selectedIndex => _selectedIndex;

  final String name = 'Your Name';
  final String title = 'Flutter Developer';
  final String bio =
      'Passionate software engineer who loves building beautiful, '
      'performant cross-platform applications with Flutter.';

  final String email = 'tade2024bdugit@gmail.com';
  final String phone = '0949847581';
  final String location = 'Addis Ababa, Ethiopia (Abyssinia)';
  final String githubUsername = 'https://github.com/Tadelachewu';
  final String githubUrl = 'https://github.com/Tadelachewu';
  final String telegramUsername = 'TadeleMesfin';
  final String telegramUrl = 'https://t.me/TadeleMesfin';
  final String linkedinUsername = 'your-linkedin';
  final String linkedinUrl = 'https://www.linkedin.com/in/your-linkedin';

  final List<Project> projects = const [
    Project(
      title: 'Portfolio App',
      description:
          'A beautiful cross-platform portfolio application built with '
          'Flutter, GoRouter and Provider, showcasing projects, education '
          'and contact information.',
      technologies: ['Flutter', 'Dart', 'GoRouter', 'Provider'],
      githubUrl: 'https://github.com/your-github/portfolio-app',
      isFeatured: true,
    ),
    Project(
      title: 'E-Commerce Store',
      description:
          'A full-featured e-commerce mobile application with product '
          'catalog, cart, checkout and payment integration.',
      technologies: ['Flutter', 'Firebase', 'Stripe', 'REST API'],
      githubUrl: 'https://github.com/your-github/ecommerce-store',
      liveUrl: 'https://example.com',
      isFeatured: true,
    ),
    Project(
      title: 'Task Manager',
      description:
          'A productivity app to manage tasks with reminders, categories '
          'and offline-first local storage.',
      technologies: ['Flutter', 'SQLite', 'Riverpod'],
      githubUrl: 'https://github.com/your-github/task-manager',
    ),
    Project(
      title: 'Weather Forecast',
      description:
          'A weather application that shows live forecasts, hourly and '
          'weekly predictions using a public weather API.',
      technologies: ['Flutter', 'Dart', 'HTTP'],
      liveUrl: 'https://example.com',
    ),
  ];

  final List<Education> education = const [
    Education(
      institution: 'University of Technology',
      degree: 'Bachelor of Science',
      field: 'Computer Science',
      period: '2019 - 2023',
      description:
          'Graduated with honors. Focused on software engineering, '
          'data structures and mobile application development.',
    ),
    Education(
      institution: 'Code Academy',
      degree: 'Professional Certificate',
      field: 'Mobile App Development',
      period: '2021',
      description:
          'Intensive hands-on program covering Flutter, Dart and modern '
          'mobile development practices.',
    ),
    Education(
      institution: 'Global High School',
      degree: 'High School Diploma',
      field: 'Science',
      period: '2015 - 2019',
      description:
          'Science track with emphasis on mathematics and computer basics.',
    ),
  ];

  void setSelectedIndex(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}