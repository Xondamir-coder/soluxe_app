import 'package:flutter/material.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/faq/faq_topics.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';

class FaqTopicsScreen extends StatelessWidget {
  const FaqTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppbar(title: 'Browse by topic'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            SlideInWidget.fade(
              begin: Offset(-0.5, 0),
              child: MySearchBar(
                label: 'Search',
                onSearch: (query) => print(query),
              ),
            ),
            FaqTopics.grid(),
          ],
        ),
      ),
    );
  }
}
