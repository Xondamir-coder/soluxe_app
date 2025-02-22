import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class MyTileStars extends StatelessWidget {
  final String star;

  const MyTileStars({required this.star, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        Row(
          children: [
            for (var i = 0; i < 5; i++)
              SvgPicture.asset(
                'assets/icons/star.svg',
                colorFilter: i < int.parse(star)
                    ? ColorFilter.mode(
                        AppColors.accentYellow,
                        BlendMode.srcIn,
                      )
                    : null,
              )
          ],
        ),
        MyText.grey(star)
      ],
    );
  }
}
