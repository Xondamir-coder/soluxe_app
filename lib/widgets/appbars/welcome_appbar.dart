import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final void Function() onTap;

  const WelcomeAppbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: AppColors.adaptiveTransparentBg(isDark),
      elevation: 0,
      actions: [
        if (currentIndex < 3)
          TextButton.icon(
            onPressed: onTap,
            label: Text(
              AppLocalizations.of(context)!.skip.toUpperCase(),
              style: GoogleFonts.instrumentSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.accentYellow,
              ),
            ),
            iconAlignment: IconAlignment.end,
            style: TextButton.styleFrom(
              overlayColor: AppColors.accentYellow,
            ),
            icon: SvgPicture.asset(
              'assets/icons/arrow-right.svg',
              width: 20,
              height: 20,
              colorFilter:
                  ColorFilter.mode(AppColors.accentYellow, BlendMode.srcIn),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
