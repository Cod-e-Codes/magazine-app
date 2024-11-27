import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';
import 'pages/article_page.dart';
import 'pages/cover_page.dart';
import 'pages/ad_page.dart';
import 'models/article.dart';
import '../providers/scroll_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ScrollProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int currentPage = 0;

  final List<Article> articles = [
    Article(
      title: 'Breaking News: Flutter 3.24 Released!',
      author: 'John Doe',
      content: '''
Flutter 3.24.0 brings significant improvements, including performance enhancements, new features, and important fixes across multiple platforms.

Here are some of the highlights:
1. Enhanced RenderFlex Baseline Intrinsics: More accurate intrinsic measurements in baseline-aligned layouts.
2. Memory Leak Fixes: Various memory leaks in components like CupertinoPageTransition, CupertinoFullscreenDialog, and Hero widgets have been resolved.
3. Expanded SelectionArea Functionality: New triple-click gesture support has been added, making text selection more versatile.
4. Cross-Platform Improvements: There is now support for Flutter Web to run as WebAssembly and updates for macOS, Linux, and Android to maintain parity across platforms.
5. Impeller Updates: Significant work on the Impeller rendering engine, focusing on performance improvements and shader support, making Flutter's graphics rendering even more powerful.

Overall, this update provides Flutter developers with better tools for building apps across web, mobile, and desktop platforms with increased performance and ease of use.
      ''',
      imageUrl: 'assets/images/flutter.png',
      publishedDate: DateTime(2024, 9, 23, 14, 30),
    ),
    Article(
      title: 'Tech Giants in 2024',
      author: 'Jane Smith',
      content: '''
In 2024, tech companies are making significant strides in artificial intelligence (AI) and sustainability. As industries become more environmentally conscious, tech giants like Google, Amazon, and Microsoft are investing in clean energy.

Key trends for 2024 include:
- AI and Automation: AI has become an integral part of modern infrastructure, assisting businesses in automating everything from customer service to manufacturing.
- Sustainability Initiatives: Companies are focusing on reducing carbon footprints, transitioning to renewable energy, and using AI to optimize resource consumption.

Tech giants are working hard to minimize environmental impact while simultaneously pushing the boundaries of technology in cloud computing, AI, and IoT.
      ''',
      imageUrl: 'assets/images/tech_giants.png',
      publishedDate: DateTime(2024, 9, 22, 10, 0),
    ),
    Article(
      title: 'Exploring the Future of Mobile Apps',
      author: 'Alice Johnson',
      content: '''
The future of mobile apps is deeply intertwined with AI, augmented reality (AR), and cross-platform development. In the coming years, mobile apps will increasingly focus on providing immersive, personalized experiences.

Some trends to watch include:
- AI-powered Personalization: Apps will leverage machine learning to anticipate user needs and adapt the experience accordingly.
- AR Integration: Expect more apps to incorporate AR, enhancing the way users interact with their surroundings, from navigation to gaming.
- Cross-platform Development: With Flutter, developers can build for multiple platforms simultaneously, saving time and improving app consistency.

With these advancements, mobile apps will become smarter, more intuitive, and capable of transforming how we interact with the digital world.
      ''',
      imageUrl: 'assets/images/future.png',
      publishedDate: DateTime(2024, 9, 22, 14, 0),
    ),
    Article(
      title: 'Sustainability in Tech',
      author: 'Michael Lee',
      content: '''
As climate change becomes an ever-pressing issue, the tech industry is stepping up to the challenge by adopting more sustainable practices.

Key efforts include:
- Switching to renewable energy: Major companies like Apple, Google, and Facebook are committing to 100% renewable energy for their data centers.
- Green Data Centers: These tech companies are optimizing data storage and reducing energy consumption in their data centers through AI and other technologies.

The tech sector has a pivotal role in shaping the future of sustainability, and the industry's ongoing efforts to reduce emissions and waste have shown that tech can be a force for good.
      ''',
      imageUrl: 'assets/images/sustainability.png',
      publishedDate: DateTime(2024, 9, 23, 15, 30),
    ),
  ];

  final List<Widget> ads = [
    const AdPage(
      adText: 'Ad: Discover the Best Tech Gadgets of 2024!',
      adImageUrl: 'assets/images/tech_gadgets.png',
    ),
    const AdPage(
      adText: 'Ad: Try the Latest Fitness Gear!',
      adImageUrl: 'assets/images/fitness_gear.png',
    ),
    const AdPage(
      adText: 'Ad: Get the Best Deals on Travel Packages!',
      adImageUrl: 'assets/images/travel_packages.png',
    ),
  ];

  List<Widget> getPages() {
    return [
      CoverPage(articleTitles: articles.map((article) => article.title).toList()), // Pass titles here
      ArticlePage(article: articles[0]),
      ads[0],
      ArticlePage(article: articles[1]),
      ArticlePage(article: articles[2]),
      ads[1],
      ArticlePage(article: articles[3]),
      ads[2],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = getPages();
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
          fontFamily: 'Montserrat',
        ),
      ),
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          fullTransitionValue: 400,
          enableLoop: true,
          waveType: WaveType.liquidReveal,
          slideIconWidget: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.arrow_back_ios,
              key: ValueKey<int>(currentPage),
              color: Colors.grey,
            ),
          ),
          onPageChangeCallback: (index) {
            setState(() {
              currentPage = index;
            });
            scrollProvider.resetScrollPosition();
          },
        ),
      ),
    );
  }
}
