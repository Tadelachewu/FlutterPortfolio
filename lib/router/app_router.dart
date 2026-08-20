import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/portfolio_provider.dart';
import '../screens/contact_screen.dart';
import '../screens/education_screen.dart';
import '../screens/home_screen.dart';
import '../screens/projects_screen.dart';

class AppRouter {
  static const String homePath = '/home';
  static const String projectsPath = '/projects';
  static const String educationPath = '/education';
  static const String contactPath = '/contact';

  static final GoRouter router = GoRouter(
    initialLocation: homePath,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: homePath,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: projectsPath,
                builder: (context, state) => const ProjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: educationPath,
                builder: (context, state) => const EducationScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: contactPath,
                builder: (context, state) => const ContactScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final portfolio = context.watch<PortfolioProvider>();

    const titles = ['Home', 'Projects', 'Education', 'Contact'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[navigationShell.currentIndex]),
        actions: [
          IconButton(
            tooltip: portfolio.isDarkMode ? 'Switch to light' : 'Switch to dark',
            icon: Icon(
              portfolio.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: portfolio.toggleDarkMode,
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: CurvedNavigationBar(
        index: navigationShell.currentIndex,
        height: 72,
        color: const Color(0xFF4F46E5),
        buttonBackgroundColor: const Color(0xFF4F46E5),
        backgroundColor: Theme.of(context).colorScheme.surface,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          _NavItem(icon: Icons.home_outlined, label: 'Home'),
          _NavItem(icon: Icons.code_outlined, label: 'Projects'),
          _NavItem(icon: Icons.school_outlined, label: 'Education'),
          _NavItem(icon: Icons.mail_outline, label: 'Contact'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 26, color: Colors.white),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}