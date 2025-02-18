import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SettingsLabel extends StatelessWidget {
  final String text;

  const SettingsLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MyText(
      text,
      color: AppColors.grey,
      fontWeight: FontWeight.w700,
    );
  }
}
