import 'package:flutter/material.dart';

class WelcomeSecond extends StatelessWidget {
  const WelcomeSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
  }
}
