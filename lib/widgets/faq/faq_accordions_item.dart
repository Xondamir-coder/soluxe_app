import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/faq_question.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class FaqAccordionsItem extends StatelessWidget {
  final FaqQuestion faqQuestion;

  const FaqAccordionsItem({
    required this.faqQuestion,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: MyText(
        faqQuestion.question,
        fontWeight: FontWeight.w700,
        color: AppColors.veryDarkBrown,
      ),
      clipBehavior: Clip.antiAlias,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedIconColor: AppColors.grey,
      iconColor: Color.fromRGBO(157, 120, 47, 1),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: MyText(
            faqQuestion.answer,
            color: Color.fromRGBO(107, 114, 128, 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                overlayColor: AppColors.darkBrown,
              ),
              label: MyText(
                'Show more',
                color: AppColors.accentYellow,
              ),
              iconAlignment: IconAlignment.end,
              icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
            ),
          ),
        ),
      ],
    );
  }
}
