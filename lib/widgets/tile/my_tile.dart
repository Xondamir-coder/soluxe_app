import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/position_helper.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/screens/hotel.dart';
import 'package:soluxe/widgets/categories/categories_bottom_sheet.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/tile/my_tile_bottom.dart';
import 'package:soluxe/widgets/tile/my_tile_image.dart';
import 'package:soluxe/widgets/tile/my_tile_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTile extends StatelessWidget {
  final Place place;

  const MyTile({
    required this.place,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          if (place.category == 'Hotels') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => HotelScreen(hotelId: place.id!),
              ),
            );
            return;
          }

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            clipBehavior: Clip.antiAlias,
            backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            builder: (ctx) => CategoriesBottomSheet(place: place),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            spacing: 10,
            children: [
              MyTileImage(
                imgSrc: '${Constants.baseUrl}/${place.images!.first}',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    MyTileTitle(
                      title: (AppLocalizations.of(context)!.localeName == 'en'
                              ? place.nameEn
                              : place.nameZh) ??
                          'Unknown',
                      color: isDark ? Colors.white : AppColors.darkBrown,
                      fontSize: 12,
                    ),
                    StarRating(star: place.reviewsAvgRating ?? 0),
                    FutureBuilder<Position>(
                        future: determinePosition(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return MyTileBottom(
                              location: place.city ?? 'Unknown',
                              distance:
                                  '${AppLocalizations.of(context)!.loading} ...',
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            {
                              final position = snapshot.data!;
                              final distance = (Geolocator.distanceBetween(
                                        position.latitude,
                                        position.longitude,
                                        place.lat,
                                        place.lng,
                                      ) /
                                      1000)
                                  .floor();
                              return MyTileBottom(
                                location: place.city ?? 'Unknown',
                                distance: '$distance',
                              );
                            }
                          } else {
                            return MyTileBottom(
                              location: place.city ?? 'Unknown',
                              distance: 'N/A',
                            );
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
