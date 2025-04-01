import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/place/hotel.dart';
import 'package:soluxe/providers/hotels_provider.dart';
import 'package:soluxe/screens/hotels.dart';
import 'package:soluxe/screens/reviews.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/hotel/hotel_comment.dart';
import 'package:soluxe/widgets/hotel/hotel_rooms_item.dart';
import 'package:soluxe/widgets/hotel/hotel_tags.dart';
import 'package:soluxe/widgets/hotel/hotel_header.dart';
import 'package:soluxe/widgets/hotel/hotel_images.dart';
import 'package:soluxe/widgets/hotel/hotel_reviews.dart';
import 'package:soluxe/widgets/hotel/hotel_rooms.dart';
import 'package:soluxe/widgets/section_header.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelScreen extends ConsumerWidget {
  final int hotelId;

  const HotelScreen({required this.hotelId, super.key});

  Future<Map<String, dynamic>> _getHotel() async {
    final token = (await LocalStorageHelper.getAccountData()).token;
    return FetchHelper.fetch(url: 'places/$hotelId', token: token);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localeName = AppLocalizations.of(context)!.localeName;

    return Scaffold(
      appBar: const DefaultAppbar(backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
          future: _getHotel(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final hotel = Hotel.fromMap(snapshot.data!);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (hotel.place?.images != null &&
                        hotel.place!.images!.isNotEmpty)
                      HotelImages(images: hotel.place!.images!),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        spacing: 16,
                        children: [
                          HotelHeader(
                            name: localeName == 'en'
                                ? hotel.place?.nameEn
                                : hotel.place?.nameZh,
                            tags: hotel.place?.uniqueTags,
                            address: hotel.place?.address,
                            priceRate: hotel.place?.priceRate,
                            reviewsAvgRating: hotel.reviewsAvgRating,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: MyText(
                              (localeName == 'en'
                                      ? hotel.place?.descriptionEn
                                      : hotel.place?.descriptionZh) ??
                                  'Unknown',
                              fontSize: 12,
                              color: AppColors.adaptiveGreyOrDarkerGrey(isDark),
                            ),
                          ),
                          if (hotel.place?.tags != null &&
                              hotel.place!.tags!.isNotEmpty)
                            HotelTags(tags: hotel.place!.uniqueTags),
                          if (hotel.place?.inside != null &&
                              hotel.place!.inside!.isNotEmpty)
                            HotelRooms(rooms: hotel.place!.inside!),
                          if (hotel.reviewsAvgRating != null)
                            Column(
                              spacing: 10,
                              children: [
                                SectionHeader(
                                  title:
                                      AppLocalizations.of(context)!.userReviews,
                                  onTap: () => hotel.place?.id != null
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => ReviewsScreen(
                                              placeId: hotel.place!.id!,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                SizedBox(
                                  height: 141,
                                  child: Row(
                                    spacing: 16,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: HotelReviews(
                                          reviews1Stars: hotel.reviews1Stars,
                                          reviews2Stars: hotel.reviews2Stars,
                                          reviews3Stars: hotel.reviews3Stars,
                                          reviews4Stars: hotel.reviews4Stars,
                                          reviews5Stars: hotel.reviews5Stars,
                                          reviewsCount: hotel.reviewsCount,
                                          reviewsAvgRating:
                                              hotel.reviewsAvgRating,
                                        ),
                                      ),
                                      if (hotel.review != null)
                                        Flexible(
                                          flex: 6,
                                          child: HotelComment(
                                            comment: hotel.review!,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (hotel.top != null)
                            Column(
                              spacing: 10,
                              children: [
                                SectionHeader(
                                  title: AppLocalizations.of(context)!
                                      .topPicksHotel,
                                  onTap: () {
                                    ref
                                        .read(hotelsProvider.notifier)
                                        .cleanHotels();
                                    ref
                                        .read(hotelsProvider.notifier)
                                        .fetchFavoriteHotels();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => HotelsScreen(),
                                      ),
                                    );
                                  },
                                ),
                                HotelRoomsItem(room: hotel.top!),
                              ],
                            )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: MyText(
                  (snapshot.error as Map)['body']['message'],
                  fontSize: 18,
                ),
              );
            }
          }),
    );
  }
}
