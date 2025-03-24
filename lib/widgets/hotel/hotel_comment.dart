import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/place/review.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelComment extends StatelessWidget {
  final Review comment;

  const HotelComment({required this.comment, super.key});

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
            comment.reviewText.toString(),
            fontSize: 12,
            color: AppColors.adaptiveAccentWhiteOrGrey(isDark),
          ),
          Row(
            spacing: 6,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: comment.user?.profilePic != null
                    ? FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            '${Constants.baseUrl}/${comment.user!.profilePic}',
                        fit: BoxFit.cover,
                        width: 32,
                        height: 32,
                      )
                    : SvgPicture.asset('assets/icons/profile.svg'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  MyText(
                    comment.user?.fullName ?? 'Unknown User',
                    fontSize: 11,
                    color: AppColors.adaptiveAlmostWhiteOrDarkBlue(isDark),
                  ),
                  MyText(
                    comment.user?.updatedAt != null
                        ? DateFormat('dd MMM yyyy').format(
                            DateTime.parse(comment.user!.updatedAt!),
                          )
                        : 'Unknown',
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
