import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class NotFound extends StatelessWidget {
  final double? topPadding;
  final String? text;

  const NotFound({super.key, this.topPadding, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      width: double.infinity,
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/vectors/not-found.svg'),
          Column(
            spacing: 8,
            children: [
              MyText(
                'Not found',
                fontSize: 24,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
              MyText.grey(
                text ?? AppLocalizations.of(context)!.noResultsFound,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              )
            ],
          )
        ],
      ),
    );
  }
}
