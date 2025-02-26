import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final double height;
  final double letterSpacing;

  const MyTitle(
    this.title, {
    this.fontSize = 24,
    this.fontWeight = FontWeight.w700,
    this.height = 1.5,
    this.letterSpacing = -0.2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: GoogleFonts.instrumentSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        color: isDark ? AppColors.beige : AppColors.darkBrown,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
