import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../routing/app_routes.dart';
import '../theme/app_gradients.dart';
import '../widgets/gradient_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'app_mark',
                  child: Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      gradient: AppGradients.primary,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.30),
                          blurRadius: 34,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 34),
                  ),
                ),
                const SizedBox(height: 18),
                Text('Digital Farewell', style: textTheme.headlineSmall)
                    .animate()
                    .fadeIn(duration: 520.ms, curve: Curves.easeOutCubic)
                    .slideY(begin: 0.12, end: 0, duration: 520.ms, curve: Curves.easeOutCubic),
                const SizedBox(height: 8),
                Text(
                  'Archive the moments. Release the noise.',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 160.ms, duration: 560.ms, curve: Curves.easeOutCubic)
                    .slideY(begin: 0.12, end: 0, delay: 160.ms, duration: 560.ms, curve: Curves.easeOutCubic),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

