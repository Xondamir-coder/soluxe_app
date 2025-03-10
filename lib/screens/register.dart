import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/provider_helper.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/buttons/provider_button.dart';
import 'package:soluxe/widgets/forms/register_form.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void foo() async {}

  void _signUpWithProvider(String name) {
    if (name == 'google') ProviderHelper.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ArrowAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
        child: Column(
          spacing: 16,
          children: [
            MyTitle('Create an account'),
            const RegisterForm(),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.softWhite.withValues(alpha: 0),
                          AppColors.softWhite.withValues(alpha: 1),
                        ],
                      ),
                    ),
                  ),
                ),
                MyText.grey('Or'),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.softWhite.withValues(alpha: 1),
                          AppColors.softWhite.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ProviderButton(
              'Sign Up with Google',
              onTap: () => _signUpWithProvider('google'),
              icon: SvgPicture.asset('assets/icons/google.svg'),
            ),
            if (Platform.isIOS)
              ProviderButton(
                'Sign Up with Apple',
                onTap: () => _signUpWithProvider('apple'),
                icon: SvgPicture.asset('assets/icons/apple.svg'),
              ),
          ],
        ),
      ),
    );
  }
}
