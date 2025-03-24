import 'package:flutter/material.dart';
import 'package:soluxe/models/place/inside.dart';
import 'package:soluxe/widgets/hotel/hotel_rooms_item.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HotelRooms extends StatelessWidget {
  final List<Inside> rooms;

  const HotelRooms({required this.rooms, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.deepBlue('Hotel Rooms', fontSize: 16),
        Column(
          spacing: 10,
          children: [
            for (final room in rooms) HotelRoomsItem(room: room),
          ],
        )
      ],
    );
  }
}
