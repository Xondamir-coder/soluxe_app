import 'package:flutter/material.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class EventDateItem extends StatelessWidget {
  final EventDate date;

  const EventDateItem({required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText.deepBlue(date.day.toString()),
          MyText.grey(date.month, fontSize: 10),
        ],
      ),
    );
  }
}
