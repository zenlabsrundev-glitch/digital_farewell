import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/time_ago.dart';
import '../widgets/glass_container.dart';
import '../widgets/seeded_art.dart';

class MemoryDetailArgs {
  const MemoryDetailArgs({
    required this.postId,
    required this.username,
    required this.avatarSeed,
    required this.timestamp,
    required this.text,
    required this.imageSeed,
    this.openComments = false,
  });

  final String postId;
  final String username;
  final int avatarSeed;
  final DateTime timestamp;
  final String text;
  final int? imageSeed;
  final bool openComments;

  static MemoryDetailArgs fallback() => MemoryDetailArgs(
        postId: 'fallback',
        username: 'user',
        avatarSeed: 1,
        timestamp: DateTime.fromMillisecondsSinceEpoch(0),
        text: 'A memory lives here.',
        imageSeed: 120,
      );
}

class MemoryDetailScreen extends StatefulWidget {
  const MemoryDetailScreen({super.key, required this.args});

  final MemoryDetailArgs args;

  @override
  State<MemoryDetailScreen> createState() => _MemoryDetailScreenState();
}

class _MemoryDetailScreenState extends State<MemoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.args.openComments) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _openComments();
      });
    }
  }

  void _openComments() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 12,
          ),
          child: GlassContainer(
            radius: 30,
            opacity: Theme.of(context).brightness == Brightness.dark ? 0.18 : 0.10,
            borderOpacity: 0.18,
            blurSigma: 22,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Comments', style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ...List.generate(5, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassContainer(
                      radius: 22,
                      opacity: Theme.of(context).brightness == Brightness.dark ? 0.14 : 0.08,
                      borderOpacity: 0.12,
                      blurSigma: 16,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SeededAvatar(seed: 70 + i, size: 34, elevation: 6),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'user_${i + 1}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'This is beautiful. The vibe is immaculate.',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 60 * i),
                          duration: 420.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .slideY(
                          begin: 0.08,
                          end: 0,
                          delay: Duration(milliseconds: 60 * i),
                          duration: 420.ms,
                          curve: Curves.easeOutCubic,
                        ),
                  );
                }),
                const SizedBox(height: 6),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Add a comment',
                    hintText: 'Write something kind…',
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 260.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.08, end: 0, duration: 260.ms, curve: Curves.easeOutCubic),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.args;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: _openComments,
            icon: const Icon(Icons.mode_comment_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'avatar_${a.postId}',
                    child: SeededAvatar(seed: a.avatarSeed, size: 52, elevation: 10),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.username, style: textTheme.titleLarge),
                        const SizedBox(height: 2),
                        Text(formatTimeAgo(a.timestamp), style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 420.ms, curve: Curves.easeOutCubic)
                  .slideY(begin: 0.06, end: 0, duration: 420.ms, curve: Curves.easeOutCubic),
              const SizedBox(height: 14),
              Text(a.text, style: textTheme.bodyLarge)
                  .animate()
                  .fadeIn(delay: 80.ms, duration: 420.ms, curve: Curves.easeOutCubic)
                  .slideY(begin: 0.06, end: 0, delay: 80.ms, duration: 420.ms, curve: Curves.easeOutCubic),
              if (a.imageSeed != null) ...[
                const SizedBox(height: 14),
                Hero(
                  tag: 'image_${a.postId}',
                  child: SeededImageCard(seed: a.imageSeed!, height: 320, radius: 28),
                )
                    .animate()
                    .fadeIn(delay: 130.ms, duration: 520.ms, curve: Curves.easeOutCubic)
                    .slideY(begin: 0.06, end: 0, delay: 130.ms, duration: 520.ms, curve: Curves.easeOutCubic),
              ],
              const SizedBox(height: 18),
              GlassContainer(
                radius: 30,
                opacity: Theme.of(context).brightness == Brightness.dark ? 0.16 : 0.10,
                borderOpacity: 0.18,
                blurSigma: 20,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _ActionPill(
                      icon: Icons.favorite_border_rounded,
                      label: 'Like',
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    _ActionPill(
                      icon: Icons.mode_comment_outlined,
                      label: 'Comment',
                      onTap: _openComments,
                    ),
                    const SizedBox(width: 10),
                    _ActionPill(
                      icon: Icons.bookmark_border_rounded,
                      label: 'Save',
                      onTap: () {},
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 180.ms, duration: 520.ms, curve: Curves.easeOutCubic)
                  .slideY(begin: 0.06, end: 0, delay: 180.ms, duration: 520.ms, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).iconTheme.color?.withValues(alpha: 0.85);
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            color: Colors.white.withValues(alpha: 0.06),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(label, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}

