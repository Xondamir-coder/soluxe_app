import 'package:flutter/material.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/widgets/tile/my_tile_bottom.dart';
import 'package:soluxe/widgets/tile/my_tile_image.dart';
import 'package:soluxe/widgets/tile/my_tile_title.dart';

class EventsCard extends StatelessWidget {
  final Event event;

  const EventsCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        spacing: 10,
        children: [
          MyTileImage(
            imgSrc: event.imgSrc,
            day: event.day,
            month: event.month,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                MyTileTitle(title: event.title),
                MyTileBottom(city: event.city, distance: event.distance),
              ],
            ),
          )
        ],
      ),
    );
  }
}
