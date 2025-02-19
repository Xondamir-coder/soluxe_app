import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class MyTileTitle extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;

  const MyTileTitle({
    super.key,
    required this.title,
    this.color = AppColors.deepBlue,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return MyText(
      title,
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color,
    );
  }
}
