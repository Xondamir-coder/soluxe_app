import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel.dart';
import 'package:soluxe/widgets/tile/my_tile_bottom.dart';
import 'package:soluxe/widgets/tile/my_tile_image.dart';
import 'package:soluxe/widgets/tile/my_tile_title.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HomeHotelCard extends StatelessWidget {
  final Hotel hotel;

  const HomeHotelCard({super.key, required this.hotel});

  Widget _buildStars() {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        spacing: 10,
        children: [
          MyTileImage(imgSrc: hotel.imgSrc),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                MyTileTitle(
                  title: hotel.name,
                  color: AppColors.darkBrown,
                  fontSize: 12,
                ),
                _buildStars(),
                MyTileBottom(city: hotel.city, distance: hotel.distance),
              ],
            ),
          )
        ],
      ),
    );
  }
}
