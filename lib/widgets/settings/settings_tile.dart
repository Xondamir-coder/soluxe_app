// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SettingsTile extends StatelessWidget {
  final String text;
  final String iconSrc;
  final void Function() onTap;

  const SettingsTile({
    super.key,
    required this.text,
    required this.iconSrc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13.5),
      visualDensity: VisualDensity.compact,
      minTileHeight: VisualDensity.minimumDensity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      leading: SvgPicture.asset(
        iconSrc,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          AppColors.grey,
          BlendMode.srcIn,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: MyText.deepBlue(text),
      ),
      tileColor: AppColors.adaptiveDarkBlueOrWhite(isDark),
      trailing: SvgPicture.asset(
        'assets/icons/arrow-right.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          AppColors.grey,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
