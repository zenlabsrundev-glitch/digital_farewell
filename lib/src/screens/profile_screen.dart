import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_gradients.dart';
import '../widgets/glass_container.dart';
import '../widgets/primary_button.dart';
import '../widgets/seeded_art.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 56, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile', style: textTheme.headlineSmall)
              .animate()
              .fadeIn(duration: 420.ms, curve: Curves.easeOutCubic)
              .slideX(begin: -0.06, end: 0, duration: 420.ms, curve: Curves.easeOutCubic),
          const SizedBox(height: 14),
          GlassContainer(
            radius: 30,
            opacity: isDark ? 0.18 : 0.10,
            borderOpacity: 0.20,
            blurSigma: 22,
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Hero(
                  tag: 'profile_avatar',
                  child: SeededAvatar(seed: 22, size: 62, elevation: 10),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('moham', style: textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(
                        'Curate your memories with a calm, premium vibe.',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 80.ms, duration: 520.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.06, end: 0, delay: 80.ms, duration: 520.ms, curve: Curves.easeOutCubic),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _StatCard(title: 'Memories', value: '48')),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(title: 'Likes', value: '1.2k')),
            ],
          )
              .animate()
              .fadeIn(delay: 140.ms, duration: 520.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.06, end: 0, delay: 140.ms, duration: 520.ms, curve: Curves.easeOutCubic),
          const SizedBox(height: 14),
          GlassContainer(
            radius: 30,
            opacity: isDark ? 0.16 : 0.09,
            borderOpacity: 0.18,
            blurSigma: 20,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Appearance', style: textTheme.titleMedium),
                    const Spacer(),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.22),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        themeMode == ThemeMode.dark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  themeMode == ThemeMode.dark
                      ? 'Dark mode is on — deep gradients and brighter glass.'
                      : 'Light mode is on — pastel gradients and clean overlays.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 14),
                PrimaryButton(
                  label: 'Toggle theme',
                  icon: Icons.swap_horiz_rounded,
                  onPressed: toggleTheme,
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 520.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.06, end: 0, delay: 200.ms, duration: 520.ms, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassContainer(
      radius: 26,
      opacity: isDark ? 0.16 : 0.10,
      borderOpacity: 0.18,
      blurSigma: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.bodyMedium),
          const SizedBox(height: 10),
          Text(value, style: textTheme.titleLarge),
        ],
      ),
    );
  }
}

