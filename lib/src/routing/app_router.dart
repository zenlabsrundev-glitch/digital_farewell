import 'package:flutter/material.dart';

import '../screens/create_memory_screen.dart';
import '../screens/home_shell.dart';
import '../screens/memory_detail_screen.dart';
import '../screens/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(
    RouteSettings settings, {
    required VoidCallback toggleTheme,
    required ThemeMode themeMode,
  }) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _fadeRoute(
          settings: settings,
          child: const SplashScreen(),
        );
      case AppRoutes.home:
        return _slideFadeRoute(
          settings: settings,
          child: HomeShell(
            toggleTheme: toggleTheme,
            themeMode: themeMode,
          ),
        );
      case AppRoutes.createMemory:
        return _slideFadeRoute(
          settings: settings,
          child: const CreateMemoryScreen(),
        );
      case AppRoutes.memoryDetail:
        final args = settings.arguments;
        if (args is MemoryDetailArgs) {
          return _slideFadeRoute(
            settings: settings,
            child: MemoryDetailScreen(args: args),
          );
        }
        return _slideFadeRoute(
          settings: settings,
          child: MemoryDetailScreen(
            args: MemoryDetailArgs.fallback(),
          ),
        );
      default:
        return _fadeRoute(
          settings: settings,
          child: const SplashScreen(),
        );
    }
  }

  static PageRouteBuilder _fadeRoute({
    required RouteSettings settings,
    required Widget child,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 360),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(opacity: curved, child: child);
      },
    );
  }

  static PageRouteBuilder _slideFadeRoute({
    required RouteSettings settings,
    required Widget child,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 520),
      reverseTransitionDuration: const Duration(milliseconds: 420),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        final offsetTween = Tween<Offset>(
          begin: const Offset(0.08, 0.02),
          end: Offset.zero,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: curved.drive(offsetTween),
            child: child,
          ),
        );
      },
    );
  }
}

