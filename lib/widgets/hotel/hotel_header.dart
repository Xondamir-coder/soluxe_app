import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/place/tag.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelHeader extends StatelessWidget {
  final List<Tag>? tags;
  final String? address;
  final String? priceRate;
  final double? reviewsAvgRating;
  final String? name;

  const HotelHeader({
    super.key,
    this.tags,
    this.address,
    this.priceRate,
    this.reviewsAvgRating,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          name ?? 'Unknown',
          color: AppColors.adaptiveAccentWhiteOrDarkBrown(isDark),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StarRating(star: reviewsAvgRating ?? 0),
            Row(
              children: [
                MyText(
                  priceRate ?? 'Unknown',
                  color: AppColors.adaptiveLightBlueOrBlue(isDark),
                ),
                const SizedBox(width: 2),
                MyText('/${AppLocalizations.of(context)!.night}',
                    color: AppColors.darkGrey, fontSize: 12),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Wrap(
                spacing: 4,
                children: [
                  SvgPicture.asset(
                    isDark
                        ? 'assets/icons/dark-pin.svg'
                        : 'assets/icons/pin.svg',
                    width: 24,
                    height: 24,
                  ),
                  MyText.grey(address ?? 'Unknown', softWrap: true),
                ],
              ),
            ),
            if (tags != null && tags!.isNotEmpty)
              Row(
                spacing: 7,
                children: [
                  for (final iconPath in tags!.map((e) => e.icon))
                    SvgPicture.string(
                      iconPath!,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.adaptiveDarkGreyOrGrey(isDark),
                        BlendMode.srcIn,
                      ),
                    ),
                ],
              ),
          ],
        )
      ],
    );
  }
}
