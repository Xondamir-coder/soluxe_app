import 'package:flutter/material.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SettingsLabel extends StatelessWidget {
  final String text;

  const SettingsLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MyText.grey(text, fontWeight: FontWeight.w700);
  }
}
