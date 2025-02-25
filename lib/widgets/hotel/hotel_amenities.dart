import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel/hotel_amenity.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HotelAmenities extends StatelessWidget {
  final List<HotelAmenity> amenities;

  const HotelAmenities({required this.amenities, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 11.5),
          decoration: BoxDecoration(
            color: AppColors.accentYellow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            spacing: 6,
            children: [
              SvgPicture.asset(
                amenities[index].iconPath,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              MyText(
                amenities[index].name,
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        separatorBuilder: (ctx, index) => const SizedBox(width: 10),
        itemCount: amenities.length,
      ),
    );
  }
}
