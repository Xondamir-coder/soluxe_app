import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/l10n/app_localizations.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 4,
          children: [
            SvgPicture.asset(
              isDark ? 'assets/icons/dark-pin.svg' : 'assets/icons/pin.svg',
              width: 13,
              height: 13,
            ),
            MyText(
              location.length > 30
                  ? '${location.substring(0, 27)}...'
                  : location,
              fontSize: 12,
              color: AppColors.grey,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.adaptiveDarkPrimaryOrVeryLightPrimary(isDark),
            borderRadius: BorderRadius.circular(6),
          ),
          child: MyText(
            '$distance ${AppLocalizations.of(context)!.km}',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        )
      ],
    );
  }
}
