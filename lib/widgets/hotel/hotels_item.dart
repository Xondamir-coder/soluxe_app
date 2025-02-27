import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel/hotel.dart';
import 'package:soluxe/screens/hotel.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelsItem extends StatelessWidget {
  final Hotel hotel;
  final int? delay;

  const HotelsItem({required this.hotel, this.delay, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              builder: (ctx) => HotelScreen(hotel: hotel),
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
                    image: hotel.imgSrc,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        hotel.title,
                        fontSize: 13,
                        color: AppColors.adaptiveAccentWhiteOrDarkBrown(isDark),
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StarRating(star: hotel.star),
                          Row(
                            spacing: 2,
                            children: [
                              MyText(
                                hotel.price,
                                fontSize: 12,
                                color:
                                    AppColors.adaptiveLightBlueOrBlue(isDark),
                                fontWeight: FontWeight.w700,
                              ),
                              MyText(
                                '/night',
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
                          MyText(
                            hotel.location,
                            fontSize: 10,
                            color: AppColors.grey,
                          ),
                          const Spacer(),
                          Row(
                            spacing: 4,
                            children: [
                              for (final amenity in hotel.amenities)
                                SvgPicture.asset(
                                  amenity.iconPath,
                                  width: 12,
                                  height: 12,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.grey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                            ],
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
