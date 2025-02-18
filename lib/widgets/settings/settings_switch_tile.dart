import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/preference_helper.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SettingsSwitchTile extends StatefulWidget {
  const SettingsSwitchTile({super.key});

  @override
  State<SettingsSwitchTile> createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
  bool? isDark;

  void _loadPreference() async {
    isDark = await PreferenceHelper.getTheme();
    setState(() {});
  }

  @override
  void initState() {
    _loadPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      visualDensity: VisualDensity.compact,
      dense: true,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      thumbColor: WidgetStateProperty.all(Colors.white),
      inactiveTrackColor: Color.fromRGBO(229, 231, 235, 1),
      activeTrackColor: AppColors.accentYellow,
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
        child: MyText.deepBlue('Dark Mode'),
      ),
      value: isDark ?? false,
      onChanged: (val) {
        setState(() {
          isDark = val;
        });
        PreferenceHelper.saveTheme(val);
      },
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
    );
  }
}
