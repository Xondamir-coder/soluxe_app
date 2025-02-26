import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';

class DragHandle extends StatelessWidget {
  final double width;
  final double height;

  const DragHandle({
    super.key,
    this.width = 32,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.adaptiveAccentBlueOrSoftWhite(isDark),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
