import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class MyText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final double height;
  final Color color;
  final TextAlign textAlign;

  const MyText(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.height = 1.5,
    this.color = AppColors.warmBrown,
    this.textAlign = TextAlign.start,
    super.key,
  });

  const MyText.deepBlue(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.w700,
    this.height = 1.5,
    this.textAlign = TextAlign.start,
    super.key,
  }) : color = AppColors.deepBlue;

  const MyText.grey(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.height = 1.5,
    this.textAlign = TextAlign.start,
    super.key,
  }) : color = AppColors.grey;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.instrumentSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
    );
  }
}
