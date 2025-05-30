import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/theme_provider.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsSwitchTile extends ConsumerWidget {
  const SettingsSwitchTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SwitchListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      visualDensity: VisualDensity.compact,
      dense: true,
      tileColor: AppColors.adaptiveDarkBlueOrWhite(isDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      thumbColor: WidgetStateProperty.all(Colors.white),
      inactiveTrackColor: Color.fromRGBO(229, 231, 235, 1),
      activeTrackColor: AppColors.adaptiveDarkerGreyOrPrimary(isDark),
      secondary: SvgPicture.asset(
        'assets/icons/moon.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          AppColors.grey,
          BlendMode.srcIn,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 10),
        child: MyText.deepBlue(AppLocalizations.of(context)!.darkMode),
      ),
      value: isDark,
      onChanged: (val) {
        ref.read(themeProvider.notifier).setTheme(val);
      },
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
    );
  }
}
