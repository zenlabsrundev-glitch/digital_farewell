import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';

class SeededAvatar extends StatelessWidget {
  const SeededAvatar({
    super.key,
    required this.seed,
    this.size = 42,
    this.elevation = 10,
  });

  final int seed;
  final double size;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final r = math.Random(seed);
    final c1 = Color.lerp(AppColors.purple, AppColors.blue, r.nextDouble())!;
    final c2 = Color.lerp(AppColors.pink, AppColors.blue, r.nextDouble())!;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [c1, c2],
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: elevation * 2.6,
            offset: Offset(0, elevation),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.person_rounded,
          size: size * 0.46,
          color: Colors.white.withValues(alpha: 0.92),
        ),
      ),
    );
  }
}

class SeededImageCard extends StatelessWidget {
  const SeededImageCard({
    super.key,
    required this.seed,
    this.height = 210,
    this.radius = 22,
  });

  final int seed;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final r = math.Random(seed);
    final c1 = Color.lerp(AppColors.purple, AppColors.pink, r.nextDouble())!;
    final c2 = Color.lerp(AppColors.blue, AppColors.purple, r.nextDouble())!;
    final c3 = Color.lerp(AppColors.pink, AppColors.blue, r.nextDouble())!;

    final gradient = LinearGradient(
      begin: Alignment(-0.9 + r.nextDouble() * 0.4, -0.8),
      end: Alignment(0.9, 0.8),
      colors: [c1, c2, c3],
      stops: const [0.0, 0.55, 1.0],
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.22,
              child: DecoratedBox(
                decoration: const BoxDecoration(gradient: AppGradients.glow),
              ),
            ),
          ),
          Positioned(
            right: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.black.withValues(alpha: 0.20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
              ),
              child: Text(
                'Memory',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

