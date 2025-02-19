import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/inputs/otp_input.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';

class VerificationScreen extends StatelessWidget {
  final List<String> otpValues = [];

  VerificationScreen({super.key});

  // Stores OTP values
  void populatOtpValues(List<String> values) {
    otpValues.clear();
    otpValues.addAll(values);
  }

  void _resendCode() {
    print('resending ...');
  }

  void _verifyCode() {
    if (otpValues.every((code) => code.isNotEmpty)) {
      print('verifying ...');
    } else {
      print('enter all codes!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appbarHeight =
        AppBar().preferredSize.height + MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: const ArrowAppbar(),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
          top: appbarHeight,
          left: 24,
          right: 24,
          bottom: 36,
        ),
        child: Stack(
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
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/verification.svg'),
                  const SizedBox(height: 40),
                  MyTitle('Verification Code'),
                  const SizedBox(height: 8),
                  Column(
                    spacing: 3,
                    children: [
                      MyText('We are sending verification code to'),
                      MyText.deepBlue('+998 90 900 09 90'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  OtpInput(
                    onChangeOtpValues: (vals) => populatOtpValues(vals),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: _resendCode,
                    style: TextButton.styleFrom(
                      overlayColor: AppColors.accentYellow,
                    ),
                    child: MyText(
                      'Resend OTP code',
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentYellow,
                    ),
                  ),
                  Spacer(),
                  YellowButton('Next', onTap: _verifyCode),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
