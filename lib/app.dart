import 'package:flutter/material.dart';

import 'src/routing/app_router.dart';
import 'src/theme/app_theme.dart';

class DigitalFarewellApp extends StatefulWidget {
  const DigitalFarewellApp({super.key});

  @override
  State<DigitalFarewellApp> createState() => _DigitalFarewellAppState();
}

class _DigitalFarewellAppState extends State<DigitalFarewellApp> {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.dark);

  @override
  void dispose() {
    _themeMode.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    _themeMode.value =
        _themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeMode,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Digital Farewell',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(
            settings,
            toggleTheme: _toggleTheme,
            themeMode: themeMode,
          ),
        );
      },
    );
  }
}

