import 'package:flutter/material.dart';

class AppColors {
  // Colors
  static const Color accentWhite = Color.fromRGBO(209, 213, 219, 1);
  static const Color creamWhite = Color.fromRGBO(248, 246, 243, 1);
  static const Color darkBrown = Color.fromRGBO(39, 30, 12, 1);
  static const Color warmBrown = Color.fromRGBO(118, 90, 35, 1);
  static const Color accentYellow = Color.fromRGBO(208, 171, 98, 1);
  static const Color yellow = Color.fromRGBO(255, 199, 0, 1);
  static const Color lightYellow = Color.fromRGBO(220, 192, 137, 1);
  static const Color darkYellow = Color.fromRGBO(157, 120, 47, 1);
  static const Color deepBlue = Color.fromRGBO(17, 24, 39, 1);
  static const Color darkBlue = Color.fromRGBO(31, 41, 55, 1);
  static const Color accentBlue = Color.fromRGBO(55, 65, 81, 1);
  static const Color blue = Color.fromRGBO(30, 106, 146, 1);
  static const Color lightBlue = Color.fromRGBO(87, 170, 214, 1);
  static const Color richBrown = Color.fromRGBO(79, 60, 23, 1);
  static const Color softWhite = Color.fromRGBO(229, 231, 235, 1);
  static const Color lightWhite = Color.fromRGBO(249, 245, 235, 1);
  static const Color lightGrey = Color.fromRGBO(243, 244, 246, 1);
  static const Color grey = Color.fromRGBO(156, 163, 175, 1);
  static const Color darkGrey = Color.fromRGBO(107, 114, 128, 1);
  static const Color darkerGrey = Color.fromRGBO(75, 85, 99, 1);
  static const Color shadyGrey = Color.fromRGBO(217, 217, 217, 1);
  static const Color veryDarkBrown = Color.fromRGBO(20, 15, 6, 1);
  static const Color almostWhite = Color.fromRGBO(249, 250, 251, 1);
  static const Color orange = Color.fromRGBO(255, 129, 66, 1);
  static const Color beige = Color.fromRGBO(243, 234, 216, 1);
  static const Color darkBeige = Color.fromRGBO(232, 213, 176, 1);

  // Conditional colors
  static Color adaptiveTransparentOrLightGrey(bool isDark) =>
      isDark ? Colors.transparent : AppColors.lightGrey;

  static Color adaptiveBeigeOrDeepBlue(bool isDark) =>
      isDark ? AppColors.beige : AppColors.deepBlue;

  static Color adaptiveLightYellowOrDarkYellow(bool isDark) =>
      isDark ? AppColors.lightYellow : AppColors.darkYellow;

  static Color adaptiveTransparentBg(bool isDark) => isDark
      ? AppColors.deepBlue.withValues(alpha: 0.01)
      : AppColors.creamWhite.withValues(alpha: 0.01);

  static Color adaptiveDarkBeigeOrWarmBrown(bool isDark) =>
      isDark ? AppColors.darkBeige : AppColors.warmBrown;

  static Color adaptiveBeigeOrDarkBrown(bool isDark) =>
      isDark ? AppColors.beige : AppColors.darkBrown;

  static Color adaptiveTransparentOrWhite(bool isDark) =>
      isDark ? Colors.transparent : Colors.white;

  static Color adaptiveLightBlueOrBlue(bool isDark) =>
      isDark ? AppColors.lightBlue : AppColors.blue;

  static Color adaptiveDeepBlueOrCreamWhite(bool isDark) =>
      isDark ? AppColors.deepBlue : AppColors.creamWhite;

  static Color adaptiveDarkBlueOrLightGrey(bool isDark) =>
      isDark ? AppColors.darkBlue : AppColors.lightGrey;

  static Color adaptivAccentBlueOrLightGrey(bool isDark) =>
      isDark ? AppColors.accentBlue : AppColors.lightGrey;

  static Color adaptiveDarkBlueOrWhite(bool isDark) =>
      isDark ? AppColors.darkBlue : Colors.white;

  static Color adaptiveAlmostWhiteOrDarkBlue(bool isDark) =>
      isDark ? AppColors.almostWhite : AppColors.darkBlue;

  static Color adaptiveSoftWhiteOrDarkBlue(bool isDark) =>
      isDark ? AppColors.softWhite : AppColors.darkBlue;

  static Color adaptiveDeepBlueOrWhite(bool isDark) =>
      isDark ? AppColors.deepBlue : Colors.white;

  static Color adaptiveDarkerGreyOrGrey(bool isDark) =>
      isDark ? AppColors.darkerGrey : AppColors.grey;

  static Color adaptiveGreyOrDarkerGrey(bool isDark) =>
      isDark ? AppColors.grey : AppColors.darkerGrey;

  static Color adaptiveDarkerGreyOrShadyGrey(bool isDark) =>
      isDark ? AppColors.darkerGrey : AppColors.shadyGrey;

  static Color adaptiveAccentBlueOrSoftWhite(bool isDark) =>
      isDark ? AppColors.accentBlue : AppColors.softWhite;

  static Color adaptiveAccentBlueOrWhite(bool isDark) =>
      isDark ? AppColors.accentBlue : Colors.white;

  static Color adaptiveLightWhiteOrRichBrown(bool isDark) =>
      isDark ? AppColors.lightWhite : AppColors.richBrown;

  static Color adaptiveDarkBrownOrLightWhite(bool isDark) =>
      isDark ? AppColors.darkBrown : AppColors.lightWhite;

  static Color adaptiveAlmostWhiteOrWarmBrown(bool isDark) =>
      isDark ? AppColors.almostWhite : AppColors.warmBrown;

  static Color adaptiveGreyOrWarmBrown(bool isDark) =>
      isDark ? AppColors.grey : AppColors.warmBrown;

  static Color adaptiveDarkGreyOrGrey(bool isDark) =>
      isDark ? AppColors.darkGrey : AppColors.grey;

  static Color adaptiveGreyOrRichBrown(bool isDark) =>
      isDark ? AppColors.grey : AppColors.richBrown;

  static Color adaptiveGreyOrDarkGrey(bool isDark) =>
      isDark ? AppColors.grey : AppColors.darkGrey;

  static Color adaptiveDeepBlueOrAlmostWhite(bool isDark) =>
      isDark ? AppColors.deepBlue : AppColors.almostWhite;

  static Color adaptiveDarkBlueOrAlmostWhite(bool isDark) =>
      isDark ? AppColors.darkBlue : AppColors.almostWhite;

  static Color adaptiveAlmostWhiteOrDeepBlue(bool isDark) =>
      isDark ? AppColors.almostWhite : AppColors.deepBlue;

  static Color adaptiveAccentWhiteOrDeepBlue(bool isDark) =>
      isDark ? AppColors.accentWhite : AppColors.deepBlue;

  static Color adaptiveAccentWhiteOrDarkerGrey(bool isDark) =>
      isDark ? AppColors.accentWhite : AppColors.darkerGrey;

  static Color adaptiveWhiteOrDeepBlue(bool isDark) =>
      isDark ? Colors.white : AppColors.deepBlue;

  static Color adaptiveGreyOrDeepBlue(bool isDark) =>
      isDark ? AppColors.grey : AppColors.deepBlue;

  static Color adaptiveDarkerGreyOrAccentYellow(bool isDark) =>
      isDark ? AppColors.darkerGrey : AppColors.accentYellow;

  static Color adaptiveAccentWhiteOrAccentYellow(bool isDark) =>
      isDark ? AppColors.accentWhite : AppColors.accentYellow;

  static Color adaptiveDarkGreyOrAccentYellow(bool isDark) =>
      isDark ? AppColors.darkGrey : AppColors.accentYellow;

  static Color adaptiveAccentWhiteOrVeryDarkBrown(bool isDark) =>
      isDark ? AppColors.accentWhite : AppColors.veryDarkBrown;

  static Color adaptiveAccentWhiteOrGrey(bool isDark) =>
      isDark ? AppColors.accentWhite : AppColors.grey;

  static Color adaptiveWhiteOrVeryDarkBrown(bool isDark) =>
      isDark ? Colors.white : AppColors.veryDarkBrown;

  static Color adaptiveAccentWhiteOrDarkBrown(bool isDark) =>
      isDark ? AppColors.accentWhite : AppColors.darkBrown;

  static Color adaptiveGreyOrDarkBrown(bool isDark) =>
      isDark ? AppColors.grey : AppColors.darkBrown;
}
