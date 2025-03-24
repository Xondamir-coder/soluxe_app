import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/hotels_provider.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_sheet.dart';
import 'package:soluxe/widgets/hotel/hotels_item.dart';

class HotelsScreen extends ConsumerWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hotels = ref.watch(hotelsProvider);

    return Scaffold(
      appBar: DefaultAppbar(
        title: 'Hotels',
        onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
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
