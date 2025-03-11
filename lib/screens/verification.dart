import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/user_summary.dart';
import 'package:soluxe/providers/user_provider.dart';
import 'package:soluxe/screens/success.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/inputs/otp_input.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:http/http.dart' as http;

class VerificationScreen extends ConsumerWidget {
  final bool isEmail;
  final String successMessage;
  final List<String> otpValues = [];

  VerificationScreen({
    super.key,
    required this.isEmail,
    required this.successMessage,
  });

  // Stores OTP values
  void populatOtpValues(List<String> values) {
    otpValues.clear();
    otpValues.addAll(values);
  }

  void _resendCode(BuildContext context, UserSummary user) async {
    final endpoint = isEmail ? 'email-send' : 'sms-send';
    try {
      // Send code to email/phone
      final res = await http.post(
        Uri.parse('${Constants.baseUrl}/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          if (isEmail) 'email': user.email,
          if (!isEmail) 'phone': user.phoneNumber,
        }),
      );

      if (res.statusCode != 200 || res.statusCode != 201) {
        throw 'Error: ${res.statusCode}';
      }

      // Show success message
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Code has been sent.')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error resending code. Try again')),
      );
    }
  }

  void _serverVerifyCode(BuildContext context, UserSummary user) async {
    final endpoint = isEmail ? 'email-verify' : 'sms-verify';
    try {
      final res = await http.post(
        Uri.parse('${Constants.baseUrl}/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          if (isEmail) 'email': user.email,
          if (!isEmail) 'phone': user.phoneNumber,
          'verify_code': otpValues.join(''),
        }),
      );

      if (res.statusCode != 200 || res.statusCode != 201) {
        throw 'Error: ${res.statusCode}';
      }

      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SuccessScreen(text: successMessage),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error verifying code. Try again')),
      );
    }
  }

  void _verifyCode(BuildContext context, UserSummary user) async {
    if (otpValues.every((code) => code.isNotEmpty)) {
      _serverVerifyCode(context, user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter all codes!')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = ref.watch(userProvider);

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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 36,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScaleUpWidget.fade(
                    child: SvgPicture.asset(
                      isDark
                          ? 'assets/icons/verification-dark.svg'
                          : 'assets/icons/verification.svg',
                    ),
                  ),
                  const SizedBox(height: 40),
                  MyTitle('Verification Code'),
                  const SizedBox(height: 8),
                  Column(
                    spacing: 3,
                    children: [
                      MyText.warmBrown(
                        'We are sending verification code to',
                        beginOffset: Offset(0, 1.5),
                        animationDelay: 200,
                      ),
                      MyText.deepBlue(
                        isEmail ? user.email! : user.phoneNumber!,
                        animationDelay: 300,
                        beginOffset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ScaleUpWidget.fade(
                    beginScale: 0.75,
                    delay: 400,
                    child: OtpInput(
                      onChangeOtpValues: (vals) => populatOtpValues(vals),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => _resendCode(context, user),
                    style: TextButton.styleFrom(
                      overlayColor: AppColors.accentYellow,
                    ),
                    child: MyText(
                      'Resend OTP code',
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentYellow,
                      animationDelay: 500,
                      beginOffset: Offset(0, 1),
                    ),
                  ),
                  Spacer(),
                  YellowButton(
                    'Next',
                    onTap: () => _verifyCode(context, user),
                    animationDelay: 600,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
