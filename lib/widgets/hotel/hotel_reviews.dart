// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HotelReviews extends StatelessWidget {
  final int? reviewsCount;
  final double? reviewsAvgRating;
  final double? reviews5Stars;
  final double? reviews4Stars;
  final double? reviews3Stars;
  final double? reviews2Stars;
  final double? reviews1Stars;

  const HotelReviews({
    super.key,
    this.reviewsCount,
    this.reviewsAvgRating,
    this.reviews5Stars,
    this.reviews4Stars,
    this.reviews3Stars,
    this.reviews2Stars,
    this.reviews1Stars,
  });

  List<double> get percentages => [
        reviews1Stars ?? 0,
        reviews2Stars ?? 0,
        reviews3Stars ?? 0,
        reviews4Stars ?? 0,
        reviews5Stars ?? 0,
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 4,
          children: [
            MyText(
              reviewsAvgRating.toString(),
              color: AppColors.orange,
              fontWeight: FontWeight.w700,
            ),
            MyText.grey('($reviewsCount)', fontSize: 12),
          ],
        ),
        Column(
          spacing: 5,
          children: [
            for (var i = percentages.length - 1; i >= 0; i--)
              Row(
                spacing: 5,
                children: [
                  SizedBox(
                    width: 8,
                    child: MyText(
                      (i + 1).toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 31, 28, 1),
                    ),
                  ),
                  SvgPicture.asset('assets/icons/circle-star.svg'),
                  Expanded(
                    child: Container(
                      height: 4, // Fixed height
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(211, 212, 212, 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: (percentages[i] / 100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ],
        )
      ],
    );
  }
}
