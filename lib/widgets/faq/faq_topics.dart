import 'package:flutter/material.dart';
import 'package:soluxe/data/faqs.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/faq/faq_topics_item.dart';

class FaqTopics extends StatelessWidget {
  final bool isGrid;

  const FaqTopics({super.key}) : isGrid = false;
  const FaqTopics.grid({super.key}) : isGrid = true;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (!isGrid) {
      content = SizedBox(
        height: 150,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) => SizedBox(
            width: 155,
            child: FaqTopicsItem(
              faqTopic: faqTopics[index],
            ),
          ),
          separatorBuilder: (ctx, index) => const SizedBox(width: 10),
          itemCount: faqTopics.length,
        ),
      );
    } else {
      content = Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 163 / 131,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (ctx, index) => ScaleUpWidget(
            delay: index * 75 + 250,
            child: FaqTopicsItem(
              faqTopic: faqTopics[index],
            ),
          ),
          itemCount: faqTopics.length,
        ),
      );
    }
    return content;
  }
}
