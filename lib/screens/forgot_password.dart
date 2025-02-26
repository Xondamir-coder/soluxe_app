import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/forms/forgot_password_form.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: ArrowAppbar(
        backgroundColor: AppColors.adaptiveTransparentBg(isDark),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: .2,
              child: SvgPicture.asset(
                'assets/vectors/pattern.svg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 36,
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/verification.svg'),
                    const SizedBox(height: 40),
                    Column(
                      spacing: 8,
                      children: [
                        MyTitle('Forgot Password'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width > 400
                              ? MediaQuery.of(context).size.width * 0.7
                              : double.infinity,
                          child: MyText.warmBrown(
                            'Please enter the email address associated with your account.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(child: const ForgotPasswordForm()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
