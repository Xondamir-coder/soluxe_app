import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class NotFound extends StatelessWidget {
  final double topPadding;

  const NotFound({super.key, required this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      width: double.infinity,
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/vectors/not-found.svg'),
          Column(
            spacing: 8,
            children: [
              MyTitle(
                'Not found',
                color: AppColors.accentYellow,
              ),
              MyText.grey(
                'Morbi magnis sollicitudin ipsum \nfacilisi vestibulum',
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ),
    );
  }
}
