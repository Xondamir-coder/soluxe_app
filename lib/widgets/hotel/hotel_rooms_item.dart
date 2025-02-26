import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel/hotel_room.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelRoomsItem extends StatelessWidget {
  final HotelRoom room;

  const HotelRoomsItem({required this.room, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      borderRadius: BorderRadius.circular(16),
      color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
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
                  image: room.imgSrc,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        room.title,
                        fontSize: 13,
                        color: AppColors.adaptiveAccentWhiteOrDarkBrown(isDark),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StarRating(star: room.star),
                        Row(
                          spacing: 2,
                          children: [
                            MyText(
                              room.price,
                              fontSize: 12,
                              color: AppColors.adaptiveLightBlueOrBlue(isDark),
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
                      spacing: 16,
                      children: [
                        for (final amenity in room.amenities)
                          Row(
                            spacing: 4,
                            children: [
                              SvgPicture.asset(
                                amenity.iconPath,
                                colorFilter: ColorFilter.mode(
                                  AppColors.grey,
                                  BlendMode.srcIn,
                                ),
                              ),
                              MyText(
                                amenity.name,
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
