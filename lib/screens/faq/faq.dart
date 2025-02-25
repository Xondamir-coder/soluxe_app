import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/faq/faq_topics.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';
import 'package:soluxe/widgets/faq/faq_accordions.dart';
import 'package:soluxe/widgets/faq/faq_topics.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/section_header.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppbar(title: 'FAQ'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            MySearchBar(
              label: 'Search',
              onSearch: (query) => print(query),
            ),
            SectionHeader(
              title: 'Browse by Topic',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const FaqTopicsScreen(),
                ),
              ),
            ),
            SlideInWidget.fade(
              begin: Offset(0, 0.25),
              child: const FaqTopics(),
            ),
            Expanded(
              child: const FaqAccordions(),
            ),
          ],
        ),
      ),
    );
  }
}
