import '../models/memory_post.dart';

List<MemoryPost> buildFakeFeed() {
  final now = DateTime.now();
  return [
    MemoryPost(
      id: 'm1',
      username: 'noor.ali',
      avatarSeed: 12,
      timestamp: now.subtract(const Duration(minutes: 18)),
      text:
          'Today felt like a soft reset. I kept the good parts, let the noise dissolve, and somehow the world got quieter.',
      imageSeed: 201,
      likeCount: 128,
      commentCount: 14,
    ),
    MemoryPost(
      id: 'm2',
      username: 'samir.k',
      avatarSeed: 44,
      timestamp: now.subtract(const Duration(hours: 2)),
      text:
          'If memories are light, then some of them are neon — they hum in the background even when you’re not looking.',
      likeCount: 54,
      commentCount: 3,
    ),
    MemoryPost(
      id: 'm3',
      username: 'lina.m',
      avatarSeed: 8,
      timestamp: now.subtract(const Duration(hours: 6)),
      text:
          'A small goodbye can still be a big beginning. Leaving space for what’s next is an act of trust.',
      imageSeed: 145,
      likeCount: 306,
      commentCount: 42,
    ),
    MemoryPost(
      id: 'm4',
      username: 'theo',
      avatarSeed: 3,
      timestamp: now.subtract(const Duration(days: 1, hours: 3)),
      text:
          'I’m learning to archive moments without clinging to them. There’s freedom in the release.',
      likeCount: 22,
      commentCount: 1,
    ),
  ];
}

