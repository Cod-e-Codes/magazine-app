import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import '../models/article.dart';

class ArticlePage extends StatefulWidget {
  final Article article;

  const ArticlePage({super.key, required this.article});

  @override
  ArticlePageState createState() => ArticlePageState();
}

class ArticlePageState extends State<ArticlePage> {
  double scrollPosition = 0.0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          scrollPosition = _scrollController.position.pixels / _scrollController.position.maxScrollExtent;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void shareArticle() {
    Share.share(
      'Check out this article: ${widget.article.title} by ${widget.article.author}\n\n${widget.article.content.substring(0, 100)}...',
      subject: widget.article.title,
    );
  }

  // Callback for like button tap
  Future<bool> onLikeButtonTapped(bool currentLikeState) async {
    // Update the isLiked value in the Article model directly
    setState(() {
      widget.article.isLiked = !currentLikeState;
    });

    return widget.article.isLiked; // return the updated isLiked state
  }

  @override
  Widget build(BuildContext context) {
    // Format the published date and time
    String formattedDate = DateFormat('MMMM dd, yyyy').format(widget.article.publishedDate);
    String formattedTime = DateFormat('h:mm a').format(widget.article.publishedDate);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article image with rounded corners and shadow
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          widget.article.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Article title
                    Text(
                      widget.article.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Author name and publish date/time in a Column to avoid overflow
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'By ${widget.article.author}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '$formattedDate at $formattedTime',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 10),

                    // Article content
                    Text(
                      widget.article.content,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Like and Share buttons
            Positioned(
              bottom: 20.0,
              left: 16.0,
              right: 16.0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Adjust the padding here
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Using LikeButton without like count
                    LikeButton(
                      size: 30,
                      circleColor: const CircleColor(
                        start: Color(0xff00ddff),
                        end: Color(0xff0099cc),
                      ),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.grey,
                          size: 30,
                        );
                      },
                      onTap: onLikeButtonTapped, // Async function for handling like/unlike
                      isLiked: widget.article.isLiked,  // Use the isLiked state from the Article model
                      likeCount: null, // Disable the like count display
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.grey, size: 30),
                      onPressed: shareArticle,
                    ),
                  ],
                ),
              ),
            ),

            // Reading progress indicator
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: scrollPosition,
                backgroundColor: Colors.grey[200],
                color: Colors.lightBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
