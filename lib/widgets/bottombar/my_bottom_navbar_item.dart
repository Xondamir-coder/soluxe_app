// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class MyBottomNavbarItem extends StatelessWidget {
  final String iconPath;
  final String text;
  final bool isActive;
  final void Function() onTap;

  const MyBottomNavbarItem({
    super.key,
    required this.iconPath,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.accentYellow.withValues(alpha: 0.2),
        highlightColor: AppColors.accentYellow.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            spacing: 4,
            mainAxisSize:
                MainAxisSize.min, // Ensures it doesn’t take full height
            children: [
              TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  begin: AppColors.grey, // Default color
                  end: isActive
                      ? AppColors.accentYellow
                      : AppColors.grey, // Animated color
                ),
                duration: const Duration(milliseconds: 300),
                builder: (context, color, child) {
                  return SvgPicture.asset(
                    iconPath,
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
                  );
                },
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: GoogleFonts.instrumentSans(
                  fontSize: 12,
                  color: isActive ? AppColors.accentYellow : AppColors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
