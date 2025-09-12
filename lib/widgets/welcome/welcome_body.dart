import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';

import 'package:soluxe/widgets/welcome/welcome_first.dart';
import 'package:soluxe/widgets/welcome/welcome_languages.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/welcome/welcome_last.dart';
import 'package:soluxe/widgets/welcome/welcome_second.dart';
import 'package:soluxe/l10n/app_localizations.dart';

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
    final localization = AppLocalizations.of(context)!;

    String? title;
    String? subtitle;
    double gap = 8;
    double fontSize = 24;
    double titleHeight = 1.5;
    Widget content;

    switch (currentIndex) {
      case 0:
        title = localization.welcomeTitle1;
        subtitle = localization.welcomeSubTitle1;
        fontSize = 32;
        gap = 12;
        titleHeight = 1.4;
        content = const WelcomeFirst();
        break;
      case 1:
        title = localization.welcomeTitle2;
        subtitle = localization.welcomeSubTitle2;
        content = const WelcomeSecond();
        break;
      case 2:
        title = localization.welcomeTitle3;
        subtitle = localization.welcomeSubTitle3;
        content = WelcomeLanguages(onTap: onTap);
        break;
      case 3:
        title = localization.welcomeTitle4;
        subtitle = localization.welcomeSubTitle4;
        fontSize = 20;
        content = const WelcomeLast();
        break;
      default:
        throw Exception('currentIndex is out of range');
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
              colorFilter: ColorFilter.mode(
                AppColors.lightPrimary,
                BlendMode.srcIn,
              ),
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
                          color: AppColors.adaptiveAccentWhiteOrDarkPrimary(
                              isDark),
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
                          child: MyText(
                            subtitle,
                            fontSize: 14,
                            color: AppColors.adaptiveAlmostWhiteOrWarmPrimary(
                                isDark),
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
                    child: YellowButton(AppLocalizations.of(context)!.letsGo,
                        onTap: onTap),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
