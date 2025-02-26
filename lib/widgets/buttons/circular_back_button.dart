import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.adaptiveDarkBlueOrWhite(isDark),
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            colorFilter: ColorFilter.mode(
              AppColors.adaptiveLightWhiteOrRichBrown(isDark),
              BlendMode.srcIn,
            ),
          ),
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
