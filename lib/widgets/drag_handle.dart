import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';

class DragHandle extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;

  const DragHandle({
    super.key,
    this.width = 32,
    this.height = 6,
    this.backgroundColor = AppColors.softWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
