import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color titleColor;
  final double titleFontSize;
  final void Function() onTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onTap,
    this.titleColor = AppColors.deepBlue,
    this.titleFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title,
          fontSize: titleFontSize,
          color: titleColor,
          fontWeight: FontWeight.w700,
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          splashColor: AppColors.warmBrown.withValues(alpha: .15),
          highlightColor: AppColors.warmBrown.withValues(alpha: .1),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              spacing: 16,
              children: [
                MyText(
                  'See All',
                  color: AppColors.accentYellow,
                ),
                SvgPicture.asset('assets/icons/arrow-right.svg'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
