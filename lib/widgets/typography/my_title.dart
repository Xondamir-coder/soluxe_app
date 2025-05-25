import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final double height;
  final double letterSpacing;
  final Color? color;

  const MyTitle(
    this.title, {
    this.fontSize = 24,
    this.fontWeight = FontWeight.w700,
    this.height = 1.5,
    this.letterSpacing = -0.2,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SlideInWidget.fade(
      begin: const Offset(0, 1),
      child: Text(
        title,
        style: GoogleFonts.instrumentSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          color: color ??
              (isDark ? AppColors.lightPrimary : AppColors.darkPrimary),
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
