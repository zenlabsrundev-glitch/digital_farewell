import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/fake_feed.dart';
import '../models/memory_post.dart';
import '../widgets/glass_container.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/memory_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late final List<MemoryPost> _feed = buildFakeFeed();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      setState(() => _loading = false);
    });
  }

  void _toggleLike(String id) {
    final post = _feed.firstWhere((p) => p.id == id);
    setState(() {
      post.isLiked = !post.isLiked;
      post.likeCount += post.isLiked ? 1 : -1;
      if (post.likeCount < 0) post.likeCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 56),
        Text('Memories', style: textTheme.headlineSmall)
            .animate()
            .fadeIn(duration: 420.ms, curve: Curves.easeOutCubic)
            .slideX(begin: -0.06, end: 0, duration: 420.ms, curve: Curves.easeOutCubic),
        const SizedBox(height: 4),
        Text(
          'A feed of moments worth keeping.',
          style: textTheme.bodyMedium,
        )
            .animate()
            .fadeIn(delay: 120.ms, duration: 420.ms, curve: Curves.easeOutCubic)
            .slideX(begin: -0.04, end: 0, delay: 120.ms, duration: 420.ms, curve: Curves.easeOutCubic),
        const SizedBox(height: 14),
        Expanded(
          child: _loading
              ? _FeedShimmer()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 10),
                  itemCount: _feed.length,
                  itemBuilder: (context, index) {
                    final post = _feed[index];
                    return MemoryCard(
                      post: post,
                      onLike: () => _toggleLike(post.id),
                      animationDelayMs: 70 * index,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _FeedShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 10),
      children: List.generate(3, (i) {
        return LoadingShimmer(
          child: GlassContainer(
            radius: 28,
            opacity: Theme.of(context).brightness == Brightness.dark ? 0.14 : 0.08,
            borderOpacity: 0.14,
            blurSigma: 18,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12, width: 120, color: Colors.white),
                          const SizedBox(height: 10),
                          Container(height: 10, width: 60, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(height: 12, width: double.infinity, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 12, width: double.infinity, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 12, width: 220, color: Colors.white),
                const SizedBox(height: 14),
                Container(height: 140, width: double.infinity, color: Colors.white),
              ],
            ),
          ),
        );
      }),
    );
  }
}

