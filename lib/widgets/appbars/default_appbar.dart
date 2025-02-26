import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/typography/title_appbar.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String iconPath;
  final void Function()? onTap;
  final Color? backgroundColor; // Make it nullable

  const DefaultAppbar({
    super.key,
    this.onTap,
    this.iconPath = '',
    this.title = '',
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor =
        backgroundColor ?? (isDark ? AppColors.deepBlue : AppColors.creamWhite);

    return AppBar(
      backgroundColor: effectiveBackgroundColor,
      elevation: 0,
      title: title.isNotEmpty
          ? TitleAppbar(
              title,
              color: isDark ? Colors.white : AppColors.deepBlue,
            )
          : null,
      centerTitle: true,
      leading: const CircularBackButton(),
      actions: iconPath.isNotEmpty
          ? [
              IconButton(
                icon: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    AppColors.adaptiveLightWhiteOrRichBrown(isDark),
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: onTap,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
