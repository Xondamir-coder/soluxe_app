import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final void Function() onTap;
  final int? totalDelay;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onTap,
    this.titleFontSize = 16,
    this.totalDelay,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title,
          beginOffset: const Offset(-0.35, 0),
          fontSize: titleFontSize,
          animationDelay: totalDelay ?? 0,
          color: AppColors.adaptiveAccentWhiteOrDeepBlue(isDark),
          fontWeight: FontWeight.w700,
        ),
        SlideInWidget.fade(
          begin: const Offset(0.35, 0),
          delay: totalDelay ?? 0,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(5),
            splashColor: AppColors.warmPrimary.withValues(alpha: .15),
            highlightColor: AppColors.warmPrimary.withValues(alpha: .1),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                spacing: 16,
                children: [
                  MyText(
                    AppLocalizations.of(context)!.seeAll,
                    color: AppColors.primary,
                  ),
                  SvgPicture.asset(
                    'assets/icons/arrow-right.svg',
                    colorFilter:
                        ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
