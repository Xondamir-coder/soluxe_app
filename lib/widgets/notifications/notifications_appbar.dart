import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/title_appbar.dart';

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.creamWhite,
      elevation: 0,
      title: const TitleAppbar('Notifications'),
      centerTitle: true,
      leading: const CircularBackButton(),
      actions: [
        IconButton(
          icon: SvgPicture.asset('assets/icons/double-check.svg'),
          onPressed: () {
            // Implement mark all as read
          },
        ),
      ],
    );
  }
}
