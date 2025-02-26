import 'package:flutter/material.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class TitleAppbar extends StatelessWidget {
  final Color color;
  final String text;

  const TitleAppbar(this.text, {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return MyText(
      text,
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }
}
