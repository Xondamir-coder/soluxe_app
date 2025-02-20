import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/typography/title_appbar.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String iconPath;
  final void Function()? onTap;

  const DefaultAppbar({
    super.key,
    required this.title,
    this.onTap,
    this.iconPath = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.creamWhite,
      elevation: 0,
      title: TitleAppbar(title),
      centerTitle: true,
      leading: const CircularBackButton(),
      actions: iconPath.isNotEmpty
          ? [
              IconButton(
                icon: SvgPicture.asset(iconPath),
                onPressed: onTap,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
