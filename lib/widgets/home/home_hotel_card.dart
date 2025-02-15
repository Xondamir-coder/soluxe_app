import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HomeHotelCard extends StatelessWidget {
  final Hotel hotel;

  const HomeHotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              hotel.imgSrc,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              spacing: 6,
              children: [
                MyText(
                  'A Cultural & Culinary Oasis: Taste Plov',
                  color: AppColors.darkBrown,
                  fontWeight: FontWeight.w700,
                ),
                Row(
                  spacing: 6,
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < 5; i++)
                          SvgPicture.asset(
                            'assets/icons/star.svg',
                            colorFilter: i < int.parse(hotel.star)
                                ? ColorFilter.mode(
                                    AppColors.accentYellow,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          )
                      ],
                    ),
                    MyText(
                      hotel.star,
                      color: AppColors.grey,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 4,
                      children: [
                        SvgPicture.asset('assets/icons/pin.svg'),
                        MyText(
                          hotel.city,
                          color: AppColors.grey,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(249, 245, 235, 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: MyText(
                        hotel.distance,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentYellow,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
