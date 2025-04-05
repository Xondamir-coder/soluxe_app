import 'package:flutter/material.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/forms/reset_password_form.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowAppbar(),
      body: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 36),
        child: Column(
          spacing: 20,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: MyTitle('Reset your password'),
            ),
            Expanded(child: ResetPasswordForm(email: email)),
          ],
        ),
      ),
    );
  }
}
