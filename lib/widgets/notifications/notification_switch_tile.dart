import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class NotificationSwitchTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const NotificationSwitchTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SwitchListTile(
      tileColor: AppColors.adaptiveDarkBlueOrWhite(isDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      inactiveTrackColor:
          isDark ? AppColors.grey : Color.fromRGBO(229, 231, 235, 1),
      activeTrackColor: AppColors.adaptiveDarkerGreyOrPrimary(isDark),
      secondary: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.adaptiveDeepBlueOrAlmostWhite(isDark),
        ),
        child: SvgPicture.asset(
          iconPath,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(
            AppColors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      dense: true,
      title: MyText.deepBlue(title),
      subtitle:
          MyText(subtitle, color: AppColors.adaptiveDarkGreyOrGrey(isDark)),
      value: value,
      onChanged: onChanged,
    );
  }
}
