import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/faq/faq_category.dart';
import 'package:soluxe/screens/faq/faq_questions.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqCategoryItem extends StatelessWidget {
  final FaqCategory faqCategory;

  const FaqCategoryItem({required this.faqCategory, super.key});

  Color _hexToColor(String hexString) {
    // Ensure the string is in the proper format
    hexString = hexString.toUpperCase().replaceAll("#", "");
    // If the string is 6 characters, add the FF prefix for full opacity
    if (hexString.length == 6) {
      hexString = "FF$hexString";
    }
    // Parse the hex string and return the Color
    return Color(int.parse(hexString, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!.localeName;

    return Material(
      color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => FaqQuestionsScreen(
              faqCategory: faqCategory,
            ),
          ),
        ),
        splashColor: _hexToColor(faqCategory.color!).withValues(alpha: 0.5),
        highlightColor: _hexToColor(faqCategory.color!).withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _hexToColor(faqCategory.color!),
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.string(
                faqCategory.icon!,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 8),
            MyText.grey(
              'Question about',
              fontSize: 12,
            ),
            MyText.deepBlue(
              (locale == 'en' ? faqCategory.titleEn : faqCategory.titleZh) ??
                  'Unknown',
            ),
          ],
        ),
      ),
    );
  }
}
