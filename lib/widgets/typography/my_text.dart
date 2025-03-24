import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';

enum MyTextVariant { warmBrown, deepBlue, grey, flexible }

class MyText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final double height;
  final Color? color;
  final TextAlign textAlign;
  final MyTextVariant variant;
  final int? animationDelay;
  final Offset? beginOffset;
  final bool? softWrap;

  const MyText(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.height = 1.5,
    this.color = AppColors.warmBrown,
    this.textAlign = TextAlign.start,
    this.animationDelay,
    this.beginOffset,
    this.softWrap,
    super.key,
  }) : variant = MyTextVariant.flexible;

  const MyText.warmBrown(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.height = 1.5,
    this.color = AppColors.warmBrown,
    this.textAlign = TextAlign.start,
    this.animationDelay,
    this.beginOffset,
    this.softWrap,
    super.key,
  }) : variant = MyTextVariant.warmBrown;

  const MyText.deepBlue(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.w700,
    this.height = 1.5,
    this.textAlign = TextAlign.start,
    this.color,
    this.animationDelay,
    this.beginOffset,
    this.softWrap,
    super.key,
  }) : variant = MyTextVariant.deepBlue;

  const MyText.grey(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.height = 1.5,
    this.textAlign = TextAlign.start,
    this.color,
    this.animationDelay,
    this.beginOffset,
    this.softWrap,
    super.key,
  }) : variant = MyTextVariant.grey;

  Color _getDefaultColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (variant) {
      case MyTextVariant.deepBlue:
        return isDark ? AppColors.almostWhite : AppColors.deepBlue;
      case MyTextVariant.grey:
        return AppColors.adaptiveDarkGreyOrGrey(isDark);
      case MyTextVariant.warmBrown:
        return AppColors.adaptiveDarkBeigeOrWarmBrown(isDark);
      case MyTextVariant.flexible:
        return color!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getDefaultColor(context);
    return SlideInWidget.fade(
      begin: beginOffset ?? const Offset(0, 0.25),
      delay: animationDelay ?? 200,
      child: Text(
        text,
        textAlign: textAlign,
        softWrap: softWrap,
        style: GoogleFonts.instrumentSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
        ),
      ),
    );
  }
}
