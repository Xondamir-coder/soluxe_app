import 'package:flutter/material.dart';
import 'package:soluxe/data/events.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/events/events_card.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 3),
      appBar: const DefaultAppbar(title: 'Events'),
      body: Column(
        spacing: 16,
        children: [
          Text('date'),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => EventsCard(
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
