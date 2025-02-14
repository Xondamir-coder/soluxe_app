import 'package:flutter/material.dart';
import 'package:soluxe/widgets/arrow_appbar.dart';
import 'package:soluxe/widgets/login/login_form.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ArrowAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
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
                    child: MyText(
                      'Let’s continue your journey through Uzbekistan—there’s so much more to explore!',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
