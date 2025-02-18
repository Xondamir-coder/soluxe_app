import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/preference_helper.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/notifications/notification_switch_tile.dart';
import 'package:soluxe/widgets/typography/title_appbar.dart';

class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  State<PushNotificationsScreen> createState() =>
      _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {
  bool? _alertPhone;
  bool? _alertEmail;
  bool? _newsletter;

  void _loadPreferences() async {
    _alertPhone = await PreferenceHelper.getAlertPhone();
    _alertEmail = await PreferenceHelper.getAlertEmail();
    _newsletter = await PreferenceHelper.getNewsletter();
    setState(() {});
  }

  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.creamWhite,
        title: const TitleAppbar('Push Notifications'),
        centerTitle: true,
        leading: const CircularBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            NotificationSwitchTile(
              iconPath: 'assets/icons/notification.svg',
              title: 'Get alert in your phone',
              subtitle: 'Get alert in your notifications',
              value: _alertPhone ?? false, // Handle null values
              onChanged: (val) {
                setState(() {
                  _alertPhone = val;
                  PreferenceHelper.saveAlertPhone(val);
                });
              },
            ),
            NotificationSwitchTile(
              iconPath: 'assets/icons/email.svg',
              title: 'Get alert in your email',
              subtitle: 'Get alert in your notifications',
              value: _alertEmail ?? false, // Handle null values
              onChanged: (val) {
                setState(() {
                  _alertEmail = val;
                  PreferenceHelper.saveAlertEmail(val);
                });
              },
            ),
            NotificationSwitchTile(
              iconPath: 'assets/icons/clipboard.svg',
              title: 'Newsletters',
              subtitle: 'Receive emails with events ',
              value: _newsletter ?? false, // Handle null values
              onChanged: (val) {
                setState(() {
                  _newsletter = val;
                  PreferenceHelper.saveNewsletter(val);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
