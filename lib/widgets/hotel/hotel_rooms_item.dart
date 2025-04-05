import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/place/inside.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/providers/currency_provider.dart';
import 'package:soluxe/screens/hotel.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelRoomsItem extends ConsumerWidget {
  final dynamic room; // room can be either an Inside or a Place

  const HotelRoomsItem({required this.room, super.key});

  // Return the primary image from the room.
  // For Place, we use the first image from its images list.
  // For Inside, we use its image property.
  String? get primaryImage {
    if (room is Place) {
      final Place place = room as Place;
      return (place.images != null && place.images!.isNotEmpty)
          ? place.images!.first
          : null;
    } else if (room is Inside) {
      final Inside inside = room as Inside;
      return inside.image;
    }
    return null;
  }

  // You can similarly provide getters for common properties if needed.
  String get roomNameEn => room.nameEn ?? 'Unknown';
  String get roomNameZh => room.nameZh ?? 'Unknown';

  double get reviewsAvgRating {
    // Note: reviewsAvgRating in Place is a double,
    // in Inside it's defined as a String in your model, so convert it.
    if (room is Place) {
      return room.reviewsAvgRating ?? 0;
    } else if (room is Inside) {
      final rating = double.tryParse(room.reviewsAvgRating?.toString() ?? '');
      return rating ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localeName = AppLocalizations.of(context)!.localeName;
    final currency = ref.read(currencyProvider);
    final price = room.priceRate == null
        ? 'Unknown'
        : '\$ ${(room.priceRate! / currency).floorToDouble()}';

    return Material(
      borderRadius: BorderRadius.circular(16),
      color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => HotelScreen(
              hotelId: room.id ?? room.placeId,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 10,
            children: [
              // Image Container
              Container(
                width: 72,
                height: 72,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: primaryImage != null
                    ? FadeInImage.memoryNetwork(
                        image: '${Constants.baseUrl}/$primaryImage',
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                      )
                    : Container(color: Colors.grey),
              ),
              // Information Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      AppLocalizations.of(context)!.localeName == 'zh'
                          ? roomNameZh
                          : roomNameEn,
                      fontSize: 13,
                      color: AppColors.adaptiveAccentWhiteOrDarkBrown(isDark),
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StarRating(star: reviewsAvgRating),
                        Row(
                          spacing: 2,
                          children: [
                            MyText(
                              price,
                              fontSize: 12,
                              color: AppColors.adaptiveLightBlueOrBlue(isDark),
                              fontWeight: FontWeight.w700,
                            ),
                            MyText(
                              '/${AppLocalizations.of(context)!.night}',
                              fontSize: 10,
                              color: AppColors.darkGrey,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (room.tags != null && room.tags.isNotEmpty)
                      Row(
                        spacing: 16,
                        children: [
                          for (final tag in room.uniqueTags)
                            Row(
                              spacing: 4,
                              children: [
                                SvgPicture.string(
                                  tag.icon,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.grey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                MyText(
                                  localeName == 'en' ? tag.nameEn : tag.nameZh,
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                              ],
                            )
                        ],
                      )
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
