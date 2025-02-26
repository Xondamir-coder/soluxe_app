import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';

class ArrowAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;

  const ArrowAppbar({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor:
          backgroundColor ?? AppColors.adaptiveDeepBlueOrCreamWhite(isDark),
      leading: const CircularBackButton(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
