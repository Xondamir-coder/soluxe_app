import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/languages.dart';
import 'package:soluxe/screens/push_notifications.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/settings/settings_tile.dart';
import 'package:soluxe/widgets/settings/settings_label.dart';
import 'package:soluxe/widgets/settings/settings_switch_tile.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/data/user.dart';
import 'package:soluxe/widgets/typography/title_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _buildProfile() {
    return Row(
      spacing: 16,
      children: [
        Container(
          width: 88,
          height: 88,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 6),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              userData.profileImgSrc,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            MyText(
              userData.name,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.deepBlue,
            ),
            MyText(
              userData.email!,
              color: AppColors.grey,
            ),
          ],
        )
      ],
    );
  }

  void _navigateTo(BuildContext context, String name) {
    if (name == 'languages') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const LanguagesScreen(),
        ),
      );
    }
    if (name == 'notifications') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const PushNotificationsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 4),
      appBar: AppBar(
        backgroundColor: AppColors.creamWhite,
        title: const TitleAppbar('Profile'),
        centerTitle: true,
        leading: const CircularBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              _buildProfile(),
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
                      const SettingsLabel(text: 'Account Setting'),
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
                      const SettingsLabel(text: 'Account Setting'),
                      Column(
                        spacing: 12,
                        children: [
                          SettingsTile(
                            text: 'Get Help',
                            iconSrc: 'assets/icons/question.svg',
                            onTap: () => _navigateTo(context, 'help'),
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
