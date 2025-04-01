import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/place/review.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelComment extends StatelessWidget {
  final Review comment;
  final double textSize;
  final double imageSize;
  final double credentialsSize;
  final double dividerSpacing;
  final double imageCredentialsSpacing;
  final double rightMargin;
  final double padding;

  const HotelComment({
    super.key,
    required this.comment,
    this.textSize = 12,
    this.credentialsSize = 11,
    this.imageSize = 32,
    this.dividerSpacing = 0,
    this.imageCredentialsSpacing = 6,
    this.rightMargin = 5,
    this.padding = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      ),
      margin: EdgeInsets.only(right: rightMargin),
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: dividerSpacing,
        children: [
          MyText(
            comment.reviewText.toString().trim(),
            fontSize: textSize,
            color: AppColors.adaptiveAccentWhiteOrGrey(isDark),
          ),
          Row(
            spacing: imageCredentialsSpacing,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: comment.user?.profilePic != null
                    ? FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            '${Constants.baseUrl}/${comment.user!.profilePic}',
                        fit: BoxFit.cover,
                        width: imageSize,
                        height: imageSize,
                      )
                    : SvgPicture.asset('assets/icons/profile.svg'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  MyText(
                    comment.user?.fullName ?? 'Unknown User',
                    fontSize: credentialsSize,
                    color: AppColors.adaptiveAlmostWhiteOrDarkBlue(isDark),
                  ),
                  MyText(
                    comment.user?.updatedAt != null
                        ? DateFormat(
                            'dd MMM yyyy',
                            AppLocalizations.of(context)!.localeName,
                          ).format(
                            DateTime.parse(comment.user!.updatedAt!),
                          )
                        : 'Unknown',
                    fontSize: credentialsSize,
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
