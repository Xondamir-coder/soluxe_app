import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/provider_helper.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/buttons/provider_button.dart';
import 'package:soluxe/widgets/forms/login_form.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends ConsumerWidget {
  final bool isEmail;

  const LoginScreen({super.key, required this.isEmail});

  void _signInWithProvider(String name, WidgetRef ref) {
    if (name == 'google') {
      ProviderHelper.signInWithGoogle(isRegister: false, ref: ref);
    }
    if (name == 'apple') {
      ProviderHelper.signInWithApple(isRegister: false, ref: ref);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    MyTitle(AppLocalizations.of(context)!.assalomuAleykum),
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 500
                          ? double.infinity
                          : 300,
                      child: MyText.warmBrown(
                        AppLocalizations.of(context)!.loginSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              LoginForm(isEmail: isEmail),
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
                    AppLocalizations.of(context)!.signInWithGoogle,
                    onTap: () => _signInWithProvider('google', ref),
                    icon: SvgPicture.asset('assets/icons/google.svg'),
                  ),
                  if (Platform.isIOS)
                    ProviderButton(
                      AppLocalizations.of(context)!.signInWithApple,
                      onTap: () => _signInWithProvider('apple', ref),
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
