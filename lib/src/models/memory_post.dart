class MemoryPost {
  MemoryPost({
    required this.id,
    required this.username,
    required this.avatarSeed,
    required this.timestamp,
    required this.text,
    this.imageSeed,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
  });

  final String id;
  final String username;
  final int avatarSeed;
  final DateTime timestamp;
  final String text;
  final int? imageSeed;
  int likeCount;
  int commentCount;
  bool isLiked;
}

