import 'package:flutter/material.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';

class WelcomeFirst extends StatelessWidget {
  const WelcomeFirst({super.key});

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
              top: 30,
              left: 0,
              child: ScaleUpWidget(
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
            ),
            Positioned(
              left: -21,
              top: MediaQuery.of(context).size.height * 0.2,
              child: ScaleUpWidget(
                delay: 150,
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
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              right: 0,
              child: ScaleUpWidget(
                delay: 300,
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
            ),
          ],
        ),
      ),
    );
  }
}
