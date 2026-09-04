import 'package:flutter/foundation.dart';

import '../models/education.dart';
import '../models/project.dart';

class PortfolioProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  int _selectedIndex = 0;

  bool get isDarkMode => _isDarkMode;
  int get selectedIndex => _selectedIndex;

  final String name = 'Tadele Mesfin';
  final String title = 'Software Engineer';
  final String bio =
      'Software Engineer at Nib International Bank, originally from '
      'Enebise Sar Midir in the Amhara Region. I hold a BSc in Computer '
      'Science from Bahir Dar University and love building beautiful, '
      'performant applications with Flutter, Next.js and AI-powered bots.';

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
      githubUrl: 'https://github.com/Tadelachewu/FlutterPortfolio',
      isFeatured: true,
    ),
    Project(
      title: 'Nib Bank Chatbot',
      description:
          'A config-driven, web-based chatbot for Nib International Bank '
          'that helps customers get banking information and support.',
      technologies: ['Next.js', 'PostgreSQL'],
      githubUrl: 'https://github.com/Tadelachewu/nibbotfinal',
      liveUrl: 'https://nibterachatboat.nibbank.com.et/',
      isFeatured: true,
    ),
    Project(
      title: 'AI CV Generator',
      description:
          'A Telegram bot that asks users for the necessary information '
          'and then generates a refined, AI-enhanced CV.',
      technologies: ['Python', 'Telegram Bot', 'AI Integration'],
      githubUrl: 'https://github.com/Tadelachewu/ai_real_cv_generator',
      liveUrl: 'https://t.me/MertuCv_bot',
      isFeatured: true,
    ),
    Project(
      title: 'Application Letter Bot',
      description:
          'A Telegram bot that generates application letters from '
          'user-provided details, enhanced and refined with AI.',
      technologies: ['Python', 'Telegram Bot', 'AI Integration'],
      githubUrl: 'https://github.com/Tadelachewu/BotApplicationLetter',
      liveUrl: 'https://t.me/ApplicationLetterByTade_bot',
    ),
  ];

  final List<Education> education = const [
    Education(
      institution: 'Bahir Dar University',
      degree: 'BSc',
      field: 'Computer Science',
      period: '2021 - 2024',
      description:
          'Studied Computer Science with a focus on software engineering '
          'and application development.',
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