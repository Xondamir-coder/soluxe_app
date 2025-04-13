import 'package:flutter/material.dart';
import 'package:soluxe/models/faq/faq_question.dart';
import 'package:soluxe/widgets/faq/faq_accordions_item.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqAccordions extends StatelessWidget {
  final List<FaqQuestion> questions;

  const FaqAccordions({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return questions.isNotEmpty
        ? ListView.separated(
            itemBuilder: (ctx, index) => SlideInWidget.fade(
              begin: Offset(0, 1),
              delay: index * 150 + 150,
              child: FaqAccordionsItem(
                faqQuestion: questions[index],
              ),
            ),
            separatorBuilder: (ctx, index) => const SizedBox(height: 12),
            itemCount: questions.length,
          )
        : MyText.deepBlue(
            AppLocalizations.of(context)!.noResultsFound,
            fontSize: 18,
          );
  }
}
