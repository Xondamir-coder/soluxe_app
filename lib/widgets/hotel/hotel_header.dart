import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HotelHeader extends StatelessWidget {
  final String star;
  final String location;
  final String price;
  final String title;
  final List<String> iconPaths;

  const HotelHeader({
    super.key,
    required this.star,
    required this.location,
    required this.price,
    required this.title,
    required this.iconPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title,
          color: AppColors.darkBrown,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StarRating(star: star),
            Row(
              children: [
                MyText(price, color: AppColors.blue),
                const SizedBox(width: 2),
                MyText('/night', color: AppColors.darkGrey, fontSize: 12),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4,
              children: [
                SvgPicture.asset(
                  'assets/icons/pin.svg',
                  width: 24,
                  height: 24,
                ),
                MyText.grey(location),
              ],
            ),
            Row(
              spacing: 7,
              children: [
                for (final iconPath in iconPaths)
                  SvgPicture.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      AppColors.grey,
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
