import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SuccessScreen extends StatelessWidget {
  final String text;

  const SuccessScreen({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const DefaultAppbar(),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/vectors/success.svg',
              ),
              const SizedBox(height: 30),
              MyText(
                text,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                color: AppColors.adaptiveBeigeOrDarkBrown(isDark),
              ),
              const Spacer(),
              YellowButton(
                'Home',
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
