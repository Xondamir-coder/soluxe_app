import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class GreyOutlinedButton extends StatelessWidget {
  final void Function() onTap;
  final String text;

  const GreyOutlinedButton(
    this.text, {
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(
          color: AppColors.lightGrey,
        ),
        padding: EdgeInsets.all(17.5),
      ),
      child: MyText.deepBlue(text),
    );
  }
}
