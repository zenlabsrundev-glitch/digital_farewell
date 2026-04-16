import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../routing/app_routes.dart';
import '../widgets/glass_container.dart';
import '../widgets/gradient_background.dart';
import 'feed_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 92),
                child: IndexedStack(
                  index: _index,
                  children: [
                    const FeedScreen(),
                    ProfileScreen(
                      toggleTheme: widget.toggleTheme,
                      themeMode: widget.themeMode,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: GlassContainer(
                    radius: 28,
                    opacity: brightness == Brightness.dark ? 0.16 : 0.10,
                    borderOpacity: 0.18,
                    blurSigma: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        _NavPill(
                          selected: _index == 0,
                          icon: Icons.dynamic_feed_rounded,
                          label: 'Feed',
                          onTap: () => setState(() => _index = 0),
                        ),
                        const SizedBox(width: 10),
                        _CreateButton(
                          onTap: () => Navigator.of(context).pushNamed(AppRoutes.createMemory),
                        ),
                        const SizedBox(width: 10),
                        _NavPill(
                          selected: _index == 1,
                          icon: Icons.person_rounded,
                          label: 'Profile',
                          onTap: () => setState(() => _index = 1),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 520.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: 0.18, end: 0, duration: 520.ms, curve: Curves.easeOutCubic),
                ),
              ),
              Positioned(
                left: 18,
                top: 10,
                child: Row(
                  children: [
                    Hero(
                      tag: 'app_mark',
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withValues(alpha: 0.12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.14),
                          ),
                        ),
                        child: const Icon(Icons.auto_awesome, size: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Digital Farewell', style: textTheme.titleMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  const _NavPill({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).iconTheme.color?.withValues(alpha: 0.72);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: selected
                ? Colors.white.withValues(alpha: 0.10)
                : Colors.transparent,
            border: Border.all(
              color: selected
                  ? Colors.white.withValues(alpha: 0.18)
                  : Colors.white.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 56,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: secondary.withValues(alpha: 0.18),
          border: Border.all(color: secondary.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: secondary.withValues(alpha: 0.20),
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Icon(Icons.add_rounded, color: secondary),
      ),
    );
  }
}

