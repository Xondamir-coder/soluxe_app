import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/screens/login.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessScreen extends StatelessWidget {
  final String text;
  final bool? goLogin;

  const SuccessScreen({required this.text, this.goLogin, super.key});

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
                isDark
                    ? 'assets/vectors/success-dark.svg'
                    : 'assets/vectors/success.svg',
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
                AppLocalizations.of(context)!.home,
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => goLogin != null
                        ? const LoginScreen(isEmail: true)
                        : const HomeScreen(),
                  ),
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
