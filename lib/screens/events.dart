import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/events_provider.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/event/events_date.dart';
import 'package:soluxe/widgets/not_found.dart';
import 'package:soluxe/widgets/tile/my_tile_event.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final events = ref.watch(eventsProvider);

    return Scaffold(
      bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 3),
      appBar: DefaultAppbar(
        backgroundColor: AppColors.adaptiveDarkBlueOrWhite(isDark),
        title: AppLocalizations.of(context)!.events,
      ),
      body: Column(
        children: [
          const EventsDate(),
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: NotFound(),
            ),
          if (events.isNotEmpty)
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) => MyTileEvent(
                  event: events[index],
                ),
                itemCount: events.length,
              ),
            ),
        ],
      ),
    );
  }
}
