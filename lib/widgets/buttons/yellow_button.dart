import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class YellowButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double borderRadius;
  final double padding;
  final int? animationDelay;

  const YellowButton(
    this.text, {
    super.key,
    required this.onTap,
    this.borderRadius = 16,
    this.padding = 17.5,
    this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleUpWidget.fade(
      beginScale: 1.15,
      delay: animationDelay ?? 300,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(padding),
            shadowColor: AppColors.primary,
          ),
          child: MyText(
            text,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
