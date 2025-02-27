import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';

import 'package:soluxe/widgets/welcome/welcome_first.dart';
import 'package:soluxe/widgets/welcome/welcome_languages.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/welcome/welcome_last.dart';
import 'package:soluxe/widgets/welcome/welcome_second.dart';

class WelcomeBody extends StatelessWidget {
  final int currentIndex;
  final void Function() onTap;

  const WelcomeBody({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String? title;
    String? subtitle;
    double gap = 8;
    double fontSize = 24;
    double titleHeight = 1.5;
    Widget content;

    if (currentIndex == 0) {
      title = 'Explore Uzbekistan like a local!';
      subtitle =
          'Your ultimate travel companion with insider tips, must-visit places, and essential travel info.';
      fontSize = 32;
      gap = 12;
      titleHeight = 1.4;
      content = const WelcomeFirst();
    } else if (currentIndex == 1) {
      title = 'Welcome to Your Pocket Guide to Uzbekistan!';
      subtitle =
          'Discover the beauty, history, and culture of Uzbekistan with ease. From ancient Silk Road cities to hidden local gems—everything you need is right at your fingertips. Let’s start exploring!';
      content = const WelcomeSecond();
    } else if (currentIndex == 2) {
      title = 'Pick a language, start exploring!';
      subtitle = 'Set your preferred language for the best experience.';
      content = WelcomeLanguages(onTap: onTap);
    } else {
      title = 'Let’s Get Started';
      subtitle = 'Class conubia dui lectus eget porta primis platea nisl risus';
      fontSize = 20;
      content = const WelcomeLast();
    }

    return Stack(
      children: [
        // Background Pattern SVG
        Positioned.fill(
          child: Opacity(
            opacity: isDark ? .1 : .2,
            child: SvgPicture.asset(
              'assets/vectors/pattern.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),

        // Foreground Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 36,
            ),
            child: Column(
              children: [
                SlideInWidget.fade(
                  begin: const Offset(0, 0.35),
                  child: Column(
                    spacing: gap,
                    crossAxisAlignment: currentIndex == 3
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: MyTitle(
                          title,
                          fontSize: fontSize,
                          height: titleHeight,
                          key:
                              ValueKey(title), // Key changes when title changes
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: SizedBox(
                          key: ValueKey(
                              subtitle), // Key changes when subtitle changes
                          width: currentIndex == 3 ? 30 * 8 : double.infinity,
                          child: MyText.warmBrown(
                            subtitle,
                            textAlign: currentIndex == 3
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: content,
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(-0.25, 0.0), // Slide in from right
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                  ),
                ),
                if (currentIndex < 2)
                  ScaleUpWidget.fade(
                    beginScale: 1.3,
                    delay: 600,
                    child: YellowButton('Kettu', onTap: onTap),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
