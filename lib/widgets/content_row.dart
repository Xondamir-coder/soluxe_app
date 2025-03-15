import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContentRow extends StatelessWidget {
  final String text;
  final String iconPath;
  final String title;
  final String phone;
  final String website;
  final bool isInteractive;

  const ContentRow({
    super.key,
    required this.title,
    required this.text,
    required this.iconPath,
  })  : isInteractive = false,
        phone = '',
        website = '';

  const ContentRow.interactive({
    super.key,
    required this.title,
    required this.phone,
    required this.website,
    required this.iconPath,
  })  : isInteractive = true,
        text = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget content = Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20,
              height: 20,
            ),
            MyText.grey(title, fontSize: 16),
          ],
        ),
        MyText(
          text,
          color: AppColors.adaptiveAlmostWhiteOrDarkBlue(isDark),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ],
    );

    if (isInteractive) {
      content = Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
              ),
              MyText.grey(title, fontSize: 16),
            ],
          ),
          InkWell(
            onTap: () {
              if (phone.isEmpty) return;
              launchUrlString('tel:$phone');
            },
            child: MyText(
              phone,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.adaptiveAlmostWhiteOrDarkBlue(isDark),
            ),
          ),
          InkWell(
            onTap: () {
              if (website.isEmpty) return;
              launchUrlString(website);
            },
            child: MyText(
              website,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.adaptiveAlmostWhiteOrDarkBlue(isDark),
            ),
          ),
        ],
      );
    }

    return content;
  }
}
