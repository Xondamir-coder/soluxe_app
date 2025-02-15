import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/login.dart';
import 'package:soluxe/screens/register.dart';
import 'package:soluxe/widgets/welcome/welcome_languages.dart';
import 'package:soluxe/widgets/buttons/provider_button.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';

class WelcomeBody extends StatelessWidget {
  final int currentIndex;
  final void Function() onTap;

  const WelcomeBody({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void _continueWithProvider(String name) {
    print(name);
  }

  void _goLoginForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
  Widget build(BuildContext context) {
    const toolbarHeight = 56;
    String? title;
    String? subtitle;
    double gap = 8;
    double fontSize = 24;
    double titleHeight = 1.5;
    Widget content = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
          vertical: 59,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 30,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/login/img-3.jpg',
                  width: 174,
                  height: 121,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: -21,
              top: MediaQuery.of(context).size.height * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/login/img-2.jpg',
                  width: 119,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    'assets/images/login/img-1.jpg',
                    width: 139,
                    height: 188,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (currentIndex == 0) {
      title = 'Explore Uzbekistan like a local!';
      subtitle =
          'Your ultimate travel companion with insider tips, must-visit places, and essential travel info.';
      fontSize = 32;
      gap = 12;
      titleHeight = 1.4;
    } else if (currentIndex == 1) {
      title = 'Welcome to Your Pocket Guide to Uzbekistan!';
      subtitle =
          'Discover the beauty, history, and culture of Uzbekistan with ease. From ancient Silk Road cities to hidden local gems—everything you need is right at your fingertips. Let’s start exploring!';
      content = SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 59,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/login/img-4.jpg',
                    width: 131,
                    height: 237,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: -21,
                top: MediaQuery.of(context).size.height * 0.05,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/login/img-5.jpg',
                    width: 131,
                    height: 237,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (currentIndex == 2) {
      title = 'Pick a language, start exploring!';
      subtitle = 'Set your preferred language for the best experience.';
      content = WelcomeLanguages(onTap: onTap);
    } else {
      title = 'Let’s Get Started';
      subtitle = 'Class conubia dui lectus eget porta primis platea nisl risus';
      fontSize = 20;
      content = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 8,
        children: [
          Image.asset(
            'assets/images/login/img-6.png',
            height: 351,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              spacing: 12,
              children: [
                YellowButton(
                  'Continue mobile phone',
                  onTap: () => _goLoginForm(context),
                ),
                ProviderButton(
                  'Continue with Google',
                  icon: SvgPicture.asset('assets/icons/google.svg'),
                  onTap: () => _continueWithProvider('google'),
                ),
                if (Platform.isIOS)
                  ProviderButton(
                    'Continue with Apple',
                    icon: SvgPicture.asset('assets/icons/apple.svg'),
                    onTap: () => _continueWithProvider('apple'),
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
                  color: AppColors.deepBlue,
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

    return Stack(
      children: [
        // Background Pattern SVG
        Positioned.fill(
          child: Opacity(
            opacity: .2,
            child: SvgPicture.asset(
              'assets/pattern.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),

        // Foreground Content
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: toolbarHeight * 2,
            bottom: 36,
          ),
          child: Column(
            children: [
              Column(
                spacing: gap,
                crossAxisAlignment: currentIndex == 3
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  MyTitle(title, fontSize: fontSize, height: titleHeight),
                  SizedBox(
                    width: currentIndex == 3 ? 30 * 8 : double.infinity,
                    child: MyText(
                      subtitle,
                      textAlign: currentIndex == 3
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                  ),
                ],
              ),
              Expanded(child: content),
              if (currentIndex < 2) YellowButton('Kettu', onTap: onTap),
            ],
          ),
        ),
      ],
    );
  }
}
