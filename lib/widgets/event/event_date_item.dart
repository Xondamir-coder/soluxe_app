import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class EventDateItem extends StatelessWidget {
  final String day;
  final String month;

  const EventDateItem({required this.month, required this.day, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText.deepBlue(day.toString()),
          MyText.grey(month, fontSize: 10),
        ],
      ),
    );
  }
}
