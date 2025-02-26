import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // Function to launch a website
  void _launchWebsite() async {
    final site = Uri.parse('https://$website');
    if (await canLaunchUrl(site)) {
      launchUrl(site);
    } else {
      throw 'Could not launch $site';
    }
  }

  // Function to make a phone call
  void _makePhoneCall() async {
    final call = Uri.parse('tel:$phone');
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }

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
            onTap: _makePhoneCall,
            child: MyText(
              phone,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.adaptiveAlmostWhiteOrDarkBlue(isDark),
            ),
          ),
          InkWell(
            onTap: _launchWebsite,
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
