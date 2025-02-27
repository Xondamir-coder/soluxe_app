import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';

class ProviderButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final SvgPicture icon;
  final int? animationDelay;

  const ProviderButton(
    this.text, {
    required this.onTap,
    required this.icon,
    this.animationDelay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ScaleUpWidget.fade(
      delay: animationDelay ?? 400,
      beginScale: 1.15,
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.adaptiveDarkBlueOrWhite(isDark),
            side: BorderSide(
              color: isDark ? Colors.transparent : AppColors.softWhite,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(17.5),
            shadowColor: AppColors.softWhite,
          ),
          child: Row(
            children: [
              icon,
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.instrumentSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.adaptiveWhiteOrDeepBlue(isDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
