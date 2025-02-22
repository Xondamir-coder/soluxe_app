import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class MyTileBottom extends StatelessWidget {
  final String location;
  final String distance;

  const MyTileBottom({
    super.key,
    required this.location,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 4,
          children: [
            SvgPicture.asset('assets/icons/pin.svg'),
            MyText.grey(
              location.length > 30
                  ? '${location.substring(0, 27)}...'
                  : location,
              fontSize: 12,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Color.fromRGBO(249, 245, 235, 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: MyText(
            '$distance Km',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.accentYellow,
          ),
        )
      ],
    );
  }
}
