import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/widgets/arrow_appbar.dart';
import 'package:soluxe/widgets/forms/forgot_password_form.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                  Column(
                    spacing: 8,
                    children: [
                      MyTitle('Forgot Password'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width > 400
                            ? MediaQuery.of(context).size.width * 0.7
                            : double.infinity,
                        child: MyText(
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
            )
          ],
        ),
      ),
    );
  }
}
