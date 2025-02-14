import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soluxe/constants/colors.dart';

class ArrowAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ArrowAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Center(
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            splashColor: AppColors.accentYellow,
            highlightColor: AppColors.accentYellow.withValues(alpha: .5),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/arrow-left.svg',
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  AppColors.richBrown,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
