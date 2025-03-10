import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/provider_helper.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/buttons/provider_button.dart';
import 'package:soluxe/widgets/forms/login_form.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _signInWithProvider(String name) {
    if (name == 'google') ProviderHelper.signInWithGoogle(isRegister: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ArrowAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              Center(
                child: Column(
                  spacing: 8,
                  children: [
                    MyTitle('Assalomu Aleykum'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 500
                          ? double.infinity
                          : 300,
                      child: MyText.warmBrown(
                        'Let’s continue your journey through Uzbekistan—there’s so much more to explore!',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              const LoginForm(),
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
              Column(
                spacing: 12,
                children: [
                  ProviderButton(
                    'Sign In with Google',
                    onTap: () => _signInWithProvider('google'),
                    icon: SvgPicture.asset('assets/icons/google.svg'),
                  ),
                  if (Platform.isIOS)
                    ProviderButton(
                      'Sign In with Apple',
                      onTap: () => _signInWithProvider('apple'),
                      icon: SvgPicture.asset('assets/icons/apple.svg'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
