import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/providers/currency_provider.dart';
import 'package:soluxe/screens/hotel.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class HotelsItem extends ConsumerWidget {
  final Place hotel;
  final int? delay;

  const HotelsItem({required this.hotel, this.delay, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currency = ref.read(currencyProvider);
    final price = hotel.priceRate == null
        ? 'Unknown'
        : '\$ ${(hotel.priceRate! / currency).floorToDouble()}';

    return ScaleUpWidget.fade(
      beginScale: 0.85,
      delay: delay ?? 0,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.adaptiveDarkBlueOrWhite(isDark),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => HotelScreen(hotelId: hotel.id!),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${Constants.baseUrl}/${hotel.images!.first}',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        (AppLocalizations.of(context)!.localeName == 'en'
                                ? hotel.nameEn
                                : hotel.nameZh) ??
                            'Unknown',
                        fontSize: 13,
                        color: AppColors.adaptiveAccentWhiteOrDarkBrown(isDark),
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StarRating(star: hotel.reviewsAvgRating ?? 0),
                          Row(
                            spacing: 2,
                            children: [
                              MyText(
                                price,
                                fontSize: 12,
                                color:
                                    AppColors.adaptiveLightBlueOrBlue(isDark),
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
                      Row(
                        children: [
                          SvgPicture.asset(isDark
                              ? 'assets/icons/dark-pin.svg'
                              : 'assets/icons/pin.svg'),
                          const SizedBox(width: 4),
                          Expanded(
                            child: MyText(
                              hotel.address ?? 'Unknown',
                              fontSize: 10,
                              softWrap: true,
                              color: AppColors.grey,
                            ),
                          ),
                          if (hotel.tags != null && hotel.tags!.isNotEmpty)
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                spacing: 4,
                                runSpacing: 4,
                                children: [
                                  for (final tag in hotel.uniqueTags)
                                    SvgPicture.string(
                                      tag.icon!,
                                      width: 12,
                                      height: 12,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
