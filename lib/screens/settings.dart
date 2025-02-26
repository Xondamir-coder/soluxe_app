import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/faq/faq.dart';
import 'package:soluxe/screens/languages.dart';
import 'package:soluxe/screens/push_notifications.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/settings/settings_tile.dart';
import 'package:soluxe/widgets/settings/settings_label.dart';
import 'package:soluxe/widgets/settings/settings_switch_tile.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/data/user.dart';
import 'package:transparent_image/transparent_image.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _buildProfile(bool isDark) {
    return Row(
      spacing: 16,
      children: [
        Container(
          width: 88,
          height: 88,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.adaptiveDarkBlueOrWhite(isDark),
              width: 6,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FadeInImage.memoryNetwork(
              image: userData.profileImgSrc,
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              userData.name,
              fontSize: 18,
              color: isDark ? AppColors.softWhite : AppColors.deepBlue,
            ),
            MyText(
              userData.email!,
              color: AppColors.adaptiveDarkerGreyOrGrey(isDark),
            ),
          ],
        )
      ],
    );
  }

  void _navigateTo(BuildContext context, String name) {
    Widget route;
    switch (name) {
      case 'languages':
        route = const LanguagesScreen();
        break;
      case 'faq':
        route = const FaqScreen();
        break;
      case 'notifications':
        route = const PushNotificationsScreen();
        break;
      default:
        route = const LanguagesScreen();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => route,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 4),
      appBar: const DefaultAppbar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              _buildProfile(isDark),
              Column(
                spacing: 24,
                children: [
                  Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SettingsLabel(text: 'Account Setting'),
                      SettingsTile(
                        text: 'Personal Information',
                        iconSrc: 'assets/icons/profile.svg',
                        onTap: () => _navigateTo(context, 'personal'),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SettingsLabel(text: 'Preference'),
                      Column(
                        spacing: 12,
                        children: [
                          SettingsTile(
                            text: 'Push notifications',
                            iconSrc: 'assets/icons/notification.svg',
                            onTap: () => _navigateTo(context, 'notifications'),
                          ),
                          SettingsTile(
                            text: 'Email updates',
                            iconSrc: 'assets/icons/email.svg',
                            onTap: () => _navigateTo(context, 'email'),
                          ),
                          SettingsTile(
                            text: 'Language',
                            iconSrc: 'assets/icons/global.svg',
                            onTap: () => _navigateTo(context, 'languages'),
                          ),
                          const SettingsSwitchTile(),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SettingsLabel(text: 'Support'),
                      Column(
                        spacing: 12,
                        children: [
                          SettingsTile(
                            text: 'FAQ',
                            iconSrc: 'assets/icons/question.svg',
                            onTap: () => _navigateTo(context, 'faq'),
                          ),
                          SettingsTile(
                            text: 'Privacy Policy',
                            iconSrc: 'assets/icons/lock.svg',
                            onTap: () => _navigateTo(context, 'policy'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
