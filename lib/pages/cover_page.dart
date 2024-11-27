import 'package:flutter/material.dart';

class CoverPage extends StatefulWidget {
  final List<String> articleTitles;

  const CoverPage({super.key, required this.articleTitles});

  @override
  CoverPageState createState() => CoverPageState();
}

class CoverPageState extends State<CoverPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final notchHeight = mediaQuery.padding.top;

    final List<String> articleDescriptions = [
      'A comprehensive guide to new features',
      'How tech giants are leading in innovation',
      'Exploring the future trends of mobile apps',
      'The latest trends in tech and sustainability'
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient with Circular Shapes
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
              ),
            ),
          ),

          // Subtle Circular Accents
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          /// "CodeVerse" Title with Shadow and Larger Text
          Positioned(
            top: notchHeight + 20,
            left: 0,
            right: 0,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  children: [
                    // Left Bracket with different color
                    TextSpan(
                      text: '{',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 60, // Increased size for better impact
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent, // Color for the brackets
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                    // "Code" part with white color
                    TextSpan(
                      text: 'Code',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 60, // Increased size for better impact
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Color for "Code"
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                    // "Verse" part with white70 color
                    TextSpan(
                      text: 'Verse',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 60, // Increased size for better impact
                        fontWeight: FontWeight.bold,
                        color: Colors.white70, // Color for "Verse"
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                    // Right Bracket with different color
                    TextSpan(
                      text: '}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 60, // Increased size for better impact
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent, // Color for the brackets
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Today's Articles Section with Enhanced Styling
          Positioned(
            top: notchHeight + 120,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Articles',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 30),

                // Display the Article Titles and Descriptions
                for (int i = 0; i < widget.articleTitles.length; i++) ...[
                  Text(
                    widget.articleTitles[i],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    articleDescriptions[i],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),

          // Call-to-Action Section with a Book Animation
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  'Swipe to Start Reading',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Animated Book
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _controller.value,
                      child: const Icon(
                        Icons.menu_book,
                        color: Colors.white70,
                        size: 40,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
