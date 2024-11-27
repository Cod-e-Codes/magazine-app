import 'package:flutter/material.dart';

class ScrollProvider with ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  void resetScrollPosition() {
    // Check if there are attached positions before resetting
    if (scrollController.hasClients) {
      scrollController.jumpTo(0.0);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
