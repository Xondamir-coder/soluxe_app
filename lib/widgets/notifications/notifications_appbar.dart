import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.creamWhite,
      elevation: 0,
      title: const MyText(
        "Notifications",
        fontSize: 16,
        color: AppColors.deepBlue,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      leading: Center(
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
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
