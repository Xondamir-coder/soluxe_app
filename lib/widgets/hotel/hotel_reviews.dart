import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel/hotel_review.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HotelReviews extends StatelessWidget {
  final HotelReview review;

  const HotelReviews({required this.review, super.key});

  List<double> get percentages => [
        review.oneStarPercentage,
        review.twoStarsPercentage,
        review.threeStarsPercentage,
        review.fourStarsPercentage,
        review.fiveStarsPercentage,
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
              review.rating.toString(),
              color: AppColors.orange,
              fontWeight: FontWeight.w700,
            ),
            MyText.grey('(${review.ratingCount})', fontSize: 12),
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
                            widthFactor: percentages[i],
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
