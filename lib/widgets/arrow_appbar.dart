import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';

class ArrowAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ArrowAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.creamWhite,
      leading: const CircularBackButton(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
