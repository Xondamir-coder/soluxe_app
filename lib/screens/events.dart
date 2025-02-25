import 'package:flutter/material.dart';
import 'package:soluxe/data/events.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/event/events_date.dart';
import 'package:soluxe/widgets/tile/my_tile.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 3),
      appBar: DefaultAppbar(
        backgroundColor: Colors.white,
        title: 'Events',
      ),
      body: Column(
        children: [
          const EventsDate(),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => MyTile(places: events[index]),
              itemCount: events.length,
            ),
          ),
        ],
      ),
    );
  }
}
