import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/languages.dart';
import 'package:soluxe/providers/locale_provider.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesScreen extends ConsumerWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locale = ref.watch(localeProvider);
    final code = locale.languageCode;

    return Scaffold(
      appBar:
          DefaultAppbar(title: AppLocalizations.of(context)!.selectLanguage),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          spacing: 10,
          children: [
            for (final language in AppLanguages.languages)
              Material(
                color: AppColors.adaptiveDarkBlueOrWhite(isDark),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () => ref
                      .read(localeProvider.notifier)
                      .setLocale(language.code),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 16,
                          children: [
                            language.icon,
                            MyText(
                              AppLocalizations.of(context)!.localeName == 'zh'
                                  ? language.nameZh
                                  : language.nameEn,
                              color: AppColors.adaptiveAlmostWhiteOrDeepBlue(
                                  isDark),
                            ),
                          ],
                        ),
                        if (code == language.code)
                          TweenAnimationBuilder<double>(
                            duration: const Duration(
                              milliseconds: 300,
                            ), // Animation duration
                            curve: Curves.ease, // Smooth easing
                            tween: Tween<double>(
                              begin: 0,
                              end: 1,
                            ), // Scale from 0 to 1
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale, // Animate the scale value
                                child: SvgPicture.asset(
                                  'assets/icons/circle-check.svg',
                                  width: 24, // Adjust size if needed
                                  height: 24,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
