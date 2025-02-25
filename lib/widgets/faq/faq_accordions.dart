import 'package:flutter/material.dart';
import 'package:soluxe/data/faqs.dart';
import 'package:soluxe/models/faq/faq_question.dart';
import 'package:soluxe/widgets/faq/faq_accordions_item.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';

class FaqAccordions extends StatelessWidget {
  final List<FaqQuestion> questions;

  const FaqAccordions({
    super.key,
    this.questions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final questionsArr = questions.isEmpty ? faqQuestions : questions;

    return ListView.separated(
      itemBuilder: (ctx, index) => SlideInWidget.fade(
        begin: Offset(0, 1),
        delay: index * 150 + 150,
        child: FaqAccordionsItem(
          faqQuestion: questionsArr[index],
        ),
      ),
      separatorBuilder: (ctx, index) => const SizedBox(height: 12),
      itemCount: questionsArr.length,
    );
  }
}
