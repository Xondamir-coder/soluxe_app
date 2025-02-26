import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/faq/faq_topic.dart';
import 'package:soluxe/screens/faq/faq_questions.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class FaqTopicsItem extends StatelessWidget {
  final FaqTopic faqTopic;

  const FaqTopicsItem({required this.faqTopic, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => FaqQuestionsScreen(
              faqTopic: faqTopic,
            ),
          ),
        ),
        splashColor: faqTopic.color.withValues(alpha: 0.5),
        highlightColor: faqTopic.color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: faqTopic.color,
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                faqTopic.iconPath,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 8),
            MyText.grey(
              'Question about',
              fontSize: 12,
            ),
            MyText.deepBlue(faqTopic.title),
          ],
        ),
      ),
    );
  }
}
