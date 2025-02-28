import 'package:flutter/material.dart';
import 'package:soluxe/data/faqs.dart';
import 'package:soluxe/models/faq/faq_topic.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/faq/faq_accordions.dart';
import 'package:soluxe/widgets/my_search_bar.dart';

class FaqQuestionsScreen extends StatelessWidget {
  final FaqTopic faqTopic;

  const FaqQuestionsScreen({
    required this.faqTopic,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final questions =
        faqQuestions.where((q) => q.topicId == faqTopic.id).toList();

    return Scaffold(
      appBar: DefaultAppbar(title: faqTopic.title),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            MySearchBar(
              label: 'Search',
              onSearch: (query) => print(query),
            ),
            Expanded(
              child: FaqAccordions(questions: questions),
            ),
          ],
        ),
      ),
    );
  }
}
