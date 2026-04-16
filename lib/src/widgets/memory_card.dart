import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/memory_post.dart';
import '../routing/app_routes.dart';
import '../screens/memory_detail_screen.dart';
import '../utils/time_ago.dart';
import 'glass_container.dart';
import 'like_button.dart';
import 'pressable_scale.dart';
import 'seeded_art.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.animationDelayMs,
  });

  final MemoryPost post;
  final VoidCallback onLike;
  final int animationDelayMs;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PressableScale(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.memoryDetail,
          arguments: MemoryDetailArgs(
            postId: post.id,
            username: post.username,
            avatarSeed: post.avatarSeed,
            timestamp: post.timestamp,
            text: post.text,
            imageSeed: post.imageSeed,
          ),
        );
      },
      child: GlassContainer(
        radius: 28,
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.18 : 0.10,
        borderOpacity: 0.20,
        blurSigma: 20,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'avatar_${post.id}',
                  child: SeededAvatar(seed: post.avatarSeed, size: 44, elevation: 8),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.username, style: textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(formatTimeAgo(post.timestamp), style: textTheme.bodyMedium),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_horiz_rounded,
                  color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.68),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(post.text, style: textTheme.bodyLarge),
            if (post.imageSeed != null) ...[
              const SizedBox(height: 14),
              Hero(
                tag: 'image_${post.id}',
                child: SeededImageCard(seed: post.imageSeed!, height: 220, radius: 24),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                LikeButton(isLiked: post.isLiked, onToggle: onLike),
                const SizedBox(width: 4),
                Text('${post.likeCount}', style: textTheme.bodyMedium),
                const SizedBox(width: 16),
                _IconAction(
                  icon: Icons.mode_comment_outlined,
                  label: '${post.commentCount}',
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.memoryDetail,
                      arguments: MemoryDetailArgs(
                        postId: post.id,
                        username: post.username,
                        avatarSeed: post.avatarSeed,
                        timestamp: post.timestamp,
                        text: post.text,
                        imageSeed: post.imageSeed,
                        openComments: true,
                      ),
                    );
                  },
                ),
                const Spacer(),
                _IconAction(
                  icon: Icons.ios_share_rounded,
                  label: 'Share',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            delay: Duration(milliseconds: animationDelayMs),
            duration: 520.ms,
            curve: Curves.easeOutCubic,
          )
          .slideY(
            begin: 0.08,
            end: 0,
            delay: Duration(milliseconds: animationDelayMs),
            duration: 520.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).iconTheme.color?.withValues(alpha: 0.78);
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

