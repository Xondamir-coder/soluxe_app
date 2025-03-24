import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class StarRating extends StatelessWidget {
  final double star;

  const StarRating({required this.star, super.key});

  @override
  Widget build(BuildContext context) {
    const maxStars = 5;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        for (var i = 0; i < maxStars; i++)
          SvgPicture.asset(
            'assets/icons/star.svg',
            colorFilter: ColorFilter.mode(
              i < star.floorToDouble()
                  ? AppColors.yellow
                  : AppColors.adaptiveDarkerGreyOrShadyGrey(isDark),
              BlendMode.srcIn,
            ),
          ),
        const SizedBox(width: 6),
        MyText.grey('${star.floorToDouble()}', fontSize: 12),
      ],
    );
  }
}
