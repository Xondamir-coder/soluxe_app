import 'package:flutter/material.dart';
import 'package:soluxe/helpers/preference_helper.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/notifications/notification_switch_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: DefaultAppbar(
        title: AppLocalizations.of(context)!.pushNotifications,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            NotificationSwitchTile(
              iconPath: 'assets/icons/notification.svg',
              title: AppLocalizations.of(context)!.getAlertPhone,
              subtitle: AppLocalizations.of(context)!.getAlertNotifications,
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
              title: AppLocalizations.of(context)!.getAlertEmail,
              subtitle: AppLocalizations.of(context)!.getAlertNotifications,
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
              title: AppLocalizations.of(context)!.newsletters,
              subtitle: AppLocalizations.of(context)!.receieveEmailsEvents,
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
