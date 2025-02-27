import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel/hotel_comment.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelCommentsItem extends StatelessWidget {
  final HotelComment comment;

  const HotelCommentsItem({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      ),
      margin: EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            comment.text,
            fontSize: 12,
            color: AppColors.adaptiveAccentWhiteOrGrey(isDark),
          ),
          Row(
            spacing: 6,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: comment.user.profileImgSrc,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  MyText(
                    comment.user.name,
                    fontSize: 11,
                    color: AppColors.adaptiveAlmostWhiteOrDarkBlue(isDark),
                  ),
                  MyText(
                    comment.formattedDate,
                    fontSize: 11,
                    color: AppColors.adaptiveAccentWhiteOrGrey(isDark),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
