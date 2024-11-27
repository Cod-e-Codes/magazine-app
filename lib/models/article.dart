class Article {
  final String title;
  final String author;
  final String content;
  final String imageUrl;
  final DateTime publishedDate;

  // New field to track if the article is liked
  bool isLiked;

  Article({
    required this.title,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.publishedDate,
    this.isLiked = false, // Default value is false
  });
}
