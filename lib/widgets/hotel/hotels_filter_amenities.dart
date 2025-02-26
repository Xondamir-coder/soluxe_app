import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel/hotel_amenity.dart';

final amenities = [
  HotelAmenity(iconPath: 'assets/icons/flash.svg', name: 'All'),
  HotelAmenity(iconPath: 'assets/icons/park.svg', name: 'Parking Slot'),
  HotelAmenity(iconPath: 'assets/icons/breakfast.svg', name: 'Breakfast'),
  HotelAmenity(iconPath: 'assets/icons/wifi.svg', name: 'Free Wifi'),
  HotelAmenity(iconPath: 'assets/icons/pool.svg', name: 'Pool'),
];

class HotelsFilterAmenities extends StatefulWidget {
  final ValueChanged<String> onAmenitySelected;

  const HotelsFilterAmenities({super.key, required this.onAmenitySelected});

  @override
  State<HotelsFilterAmenities> createState() => _HotelsFilterAmenitiesState();
}

class _HotelsFilterAmenitiesState extends State<HotelsFilterAmenities> {
  var _selectedAmenityName = amenities[0].name;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (ctx, index) => const SizedBox(width: 10),
        itemBuilder: (ctx, index) {
          final amenity = amenities[index];
          final isSelected = _selectedAmenityName == amenity.name;
          final color = isSelected
              ? Colors.white
              : AppColors.adaptiveAccentWhiteOrVeryDarkBrown(isDark);

          return GestureDetector(
            onTap: () {
              // Update UI
              setState(() => _selectedAmenityName = amenity.name);

              // Pass to the parent
              widget.onAmenitySelected(_selectedAmenityName);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentYellow
                    : AppColors.adaptiveDarkBlueOrLightGrey(isDark),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                spacing: 6,
                children: [
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: AppColors.veryDarkBrown,
                      end: color,
                    ),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, color, child) {
                      return SvgPicture.asset(
                        amenity.iconPath,
                        width: 15,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                          color ?? AppColors.veryDarkBrown,
                          BlendMode.srcIn,
                        ),
                      );
                    },
                  ),
                  AnimatedDefaultTextStyle(
                    style: GoogleFonts.instrumentSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                    duration: const Duration(milliseconds: 300),
                    child: Text(amenity.name),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: amenities.length,
      ),
    );
  }
}
