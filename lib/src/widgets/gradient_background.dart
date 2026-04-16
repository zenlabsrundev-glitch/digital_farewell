import 'package:flutter/material.dart';

import '../theme/app_gradients.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: isDark ? AppGradients.darkBackground : AppGradients.lightBackground,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.glow),
        child: child,
      ),
    );
  }
}

