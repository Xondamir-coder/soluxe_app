import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class LoginAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const LoginAppbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        TextButton.icon(
          onPressed: () {},
          label: Text(
            'skip'.toUpperCase(),
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
