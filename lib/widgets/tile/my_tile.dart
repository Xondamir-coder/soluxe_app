import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/places.dart';
import 'package:soluxe/widgets/categories/categories_bottom_sheet.dart';
import 'package:soluxe/widgets/tile/my_tile_bottom.dart';
import 'package:soluxe/widgets/tile/my_tile_image.dart';
import 'package:soluxe/widgets/tile/my_tile_stars.dart';
import 'package:soluxe/widgets/tile/my_tile_title.dart';

class MyTile extends StatelessWidget {
  final Places places;
  final bool dateOnImage;
  final bool isStars;

  const MyTile({
    this.dateOnImage = false,
    this.isStars = true,
    required this.places,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double spacing = 16;
    Color titleColor = AppColors.deepBlue;
    double titleFontSize = 14;

    if (isStars) {
      spacing = 6;
      titleColor = AppColors.darkBrown;
      titleFontSize = 12;
    }

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            builder: (ctx) => const CategoriesBottomSheet(),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            spacing: 10,
            children: [
              if (dateOnImage)
                MyTileImage(
                  imgSrc: places.imgSrc,
                  day: places.day,
                  month: places.month,
                ),
              if (!dateOnImage) MyTileImage(imgSrc: places.imgSrc),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spacing,
                  children: [
                    MyTileTitle(
                      title: places.title,
                      color: titleColor,
                      fontSize: titleFontSize,
                    ),
                    if (isStars) MyTileStars(star: places.star),
                    MyTileBottom(
                        location: places.location, distance: places.distance),
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
