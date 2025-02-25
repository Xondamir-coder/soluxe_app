import 'package:flutter/material.dart';
import 'package:soluxe/data/hotels.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_sheet.dart';
import 'package:soluxe/widgets/hotel/hotels_item.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        title: 'Hotels',
        onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          builder: (ctx) => const HotelsFilterSheet(),
        ),
        iconPath: 'assets/icons/filter.svg',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (ctx, index) => const SizedBox(height: 10),
          itemBuilder: (ctx, index) => HotelsItem(hotel: hotels[index]),
          itemCount: hotels.length,
        ),
      ),
    );
  }
}
