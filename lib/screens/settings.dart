import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/account.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/screens/faq/faq.dart';
import 'package:soluxe/screens/languages.dart';
import 'package:soluxe/screens/personal_info.dart';
import 'package:soluxe/screens/privacy_policy.dart';
import 'package:soluxe/screens/push_notifications.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/settings/settings_tile.dart';
import 'package:soluxe/widgets/settings/settings_label.dart';
import 'package:soluxe/widgets/settings/settings_switch_tile.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Widget _buildProfile(bool isDark, Account account) {
    return Row(
      spacing: 16,
      children: [
        Container(
          width: 88,
          height: 88,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.adaptiveDarkBlueOrWhite(isDark),
            border: Border.all(
              color: AppColors.adaptiveDarkBlueOrWhite(isDark),
              width: 6,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: account.user?.profilePic != null
                ? FadeInImage.memoryNetwork(
                    image: '${Constants.baseUrl}/${account.user!.profilePic!}',
                    placeholder: kTransparentImage,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    'assets/icons/profile.svg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              account.user?.fullName ?? 'N/A',
              fontSize: 18,
              color: isDark ? AppColors.softWhite : AppColors.deepBlue,
            ),
            MyText(
              account.user?.email ?? 'N/A',
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
      case 'policy':
        route = const PrivacyPolicyScreen();
        break;
      case 'personal':
        route = const PersonalInfoScreen();
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final account = ref.watch(accountProvider);

    return Scaffold(
      bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 4),
      appBar: DefaultAppbar(title: AppLocalizations.of(context)!.profile),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              _buildProfile(isDark, account),
              Column(
                spacing: 24,
                children: [
                  Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsLabel(
                        text: AppLocalizations.of(context)!.accountSetting,
                      ),
                      SettingsTile(
                        text: AppLocalizations.of(context)!.personalInformation,
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
                            text:
                                AppLocalizations.of(context)!.pushNotifications,
                            iconSrc: 'assets/icons/notification.svg',
                            onTap: () => _navigateTo(context, 'notifications'),
                          ),
                          SettingsTile(
                            text: AppLocalizations.of(context)!.emailUpdates,
                            iconSrc: 'assets/icons/email.svg',
                            onTap: () => _navigateTo(context, 'email'),
                          ),
                          SettingsTile(
                            text: AppLocalizations.of(context)!.language,
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
                      SettingsLabel(
                        text: AppLocalizations.of(context)!.support,
                      ),
                      Column(
                        spacing: 12,
                        children: [
                          SettingsTile(
                            text: AppLocalizations.of(context)!.faq,
                            iconSrc: 'assets/icons/question.svg',
                            onTap: () => _navigateTo(context, 'faq'),
                          ),
                          SettingsTile(
                            text: AppLocalizations.of(context)!.privacyPolicy,
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
