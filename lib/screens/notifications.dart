import 'package:flutter/material.dart';
import 'package:soluxe/data/notifications.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/not_found.dart';
import 'package:soluxe/widgets/notifications/notifications_card.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  void _markAllAsRead() {
    //TODO: mark all as read
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        title: AppLocalizations.of(context)!.notifications,
        iconPath: 'assets/icons/double-check.svg',
        onTap: _markAllAsRead,
      ),
      body: notifications.isEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => NotificationsCard(
                notification: notifications[index],
                isLastCard: index == notifications.length - 1,
              ),
            )
          : NotFound(topPadding: 80),
    );
  }
}
