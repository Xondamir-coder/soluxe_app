import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_sheet.dart';
import 'package:soluxe/widgets/hotel/hotels_item.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  final _params = ValueNotifier({});

  Future<List<Place>> _fetchHotels() async {
    try {
      final List<Place> arr = [];
      final token = (await LocalStorageHelper.getAccountData()).token;
      final body = await FetchHelper.fetch(
        url: 'places',
        token: token,
        queryParams: {'category': 'Hotels', ..._params.value},
      );
      if ((body['data'] as List).isEmpty) return [];

      for (final data in body['data']) {
        arr.add(Place.fromMap(data));
      }
      return arr;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: DefaultAppbar(
        title: AppLocalizations.of(context)!.hotels,
        onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          builder: (ctx) =>
              HotelsFilterSheet(onApplyFilters: (val) => _params.value = val),
        ),
        iconPath: 'assets/icons/filter.svg',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: _params,
          builder: (ctx, val, child) => FutureBuilder(
            future: _fetchHotels(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  final hotels = snapshot.data!;
                  return ListView.separated(
                    separatorBuilder: (ctx, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (ctx, index) =>
                        HotelsItem(hotel: hotels[index]),
                    itemCount: hotels.length,
                  );
                } else {
                  return Center(
                    child: MyText.warmBrown('No hotels found', fontSize: 20),
                  );
                }
              } else {
                return Center(
                  child: MyText.warmBrown(
                    snapshot.error.toString(),
                    fontSize: 20,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
