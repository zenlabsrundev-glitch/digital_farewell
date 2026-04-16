import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.isLiked,
    required this.onToggle,
  });

  final bool isLiked;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final color = isLiked
        ? const Color(0xFFFF4FD8)
        : Theme.of(context).iconTheme.color?.withValues(alpha: 0.82);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        HapticFeedback.lightImpact();
        onToggle();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          switchInCurve: Curves.easeOutBack,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, anim) {
            return ScaleTransition(scale: anim, child: FadeTransition(opacity: anim, child: child));
          },
          child: Icon(
            isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            key: ValueKey(isLiked),
            size: 20,
            color: color,
          )
              .animate(target: isLiked ? 1 : 0)
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.08, 1.08),
                duration: 220.ms,
                curve: Curves.easeOutBack,
              )
              .then()
              .scale(
                begin: const Offset(1.08, 1.08),
                end: const Offset(1, 1),
                duration: 180.ms,
                curve: Curves.easeOutCubic,
              ),
        ),
      ),
    );
  }
}

