import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/provider_helper.dart';
import 'package:soluxe/screens/login.dart';
import 'package:soluxe/screens/register.dart';
import 'package:soluxe/widgets/buttons/provider_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';

class WelcomeLast extends ConsumerWidget {
  const WelcomeLast({super.key});

  void _continueWithProvider(String name, WidgetRef ref) {
    if (name == 'google') ProviderHelper.signInWithGoogle(ref: ref);
    if (name == 'apple') ProviderHelper.signInWithApple(ref: ref);
  }

  void _goLoginForm(BuildContext context, {bool isEmail = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(isEmail: isEmail),
      ),
    );
  }

  void _goRegisterForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: [
        Image.asset(
          isDark
              ? 'assets/images/welcome-dark-pattern.png'
              : 'assets/images/login/img-6.png',
          height: 351,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            spacing: 12,
            children: [
              YellowButton(
                'Continue with phone',
                onTap: () => _goLoginForm(context),
              ),
              YellowButton(
                'Continue with email',
                onTap: () => _goLoginForm(context, isEmail: true),
              ),
              ProviderButton(
                'Continue with Google',
                icon: SvgPicture.asset('assets/icons/google.svg'),
                onTap: () => _continueWithProvider('google', ref),
              ),
              if (Platform.isIOS)
                ProviderButton(
                  'Continue with Apple',
                  icon: SvgPicture.asset('assets/icons/apple.svg'),
                  onTap: () => _continueWithProvider('apple', ref),
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account?',
              style: GoogleFonts.instrumentSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.adaptiveWhiteOrDeepBlue(isDark),
              ),
            ),
            TextButton(
              onPressed: () => _goRegisterForm(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accentYellow,
                textStyle: GoogleFonts.instrumentSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text('Signup'),
            ),
          ],
        )
      ],
    );
  }
}
