import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
