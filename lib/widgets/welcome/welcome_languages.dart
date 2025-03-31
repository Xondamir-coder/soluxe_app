import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/languages.dart';
import 'package:soluxe/providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeLanguages extends ConsumerWidget {
  final void Function() onTap;

  const WelcomeLanguages({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final code = ref.watch(localeProvider).languageCode;

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        spacing: 16,
        children: [
          for (final language in AppLanguages.languages)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColors.adaptiveAccentBlueOrSoftWhite(isDark),
                    width: 1),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.adaptiveDarkBlueOrWhite(isDark),
                clipBehavior: Clip.hardEdge,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: AppColors.accentYellow.withValues(alpha: 0.75),
                    highlightColor:
                        AppColors.accentYellow.withValues(alpha: 0.5),
                  ),
                  child: RadioListTile(
                    contentPadding:
                        EdgeInsets.only(left: 16, right: 9, top: 9, bottom: 9),
                    value: language.code,
                    groupValue: code,
                    dense: true,
                    onChanged: (value) {
                      ref.read(localeProvider.notifier).setLocale(value!);
                      onTap();
                    },
                    title: Row(
                      children: [
                        language.icon,
                        SizedBox(width: 16),
                        Text(
                          AppLocalizations.of(context)!.localeName == 'zh'
                              ? language.nameZh
                              : language.nameEn,
                          style: GoogleFonts.instrumentSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:
                                AppColors.adaptiveAccentWhiteOrDeepBlue(isDark),
                          ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: AppColors.accentYellow,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
