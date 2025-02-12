import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final double height;
  final double letterSpacing;
  final Color color;

  const MyTitle(
    this.title, {
    this.fontSize = 24,
    this.fontWeight = FontWeight.w700,
    this.height = 1.5,
    this.color = AppColors.darkBrown,
    this.letterSpacing = -0.2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.instrumentSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
