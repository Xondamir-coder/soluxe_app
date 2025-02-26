import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/languages.dart';
import 'package:soluxe/helpers/preference_helper.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  String? _langCode;

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Call async function
  }

  Future<void> _loadLanguage() async {
    _langCode = await PreferenceHelper.getLanguage();
    setState(() {}); // Update UI after fetching language
  }

  void _setLang(String code) async {
    setState(() {
      _langCode = code;
    });
    await PreferenceHelper.saveLanguage(code);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const DefaultAppbar(title: 'Select Language'),
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
                  onTap: () => _setLang(language.code),
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
                              language.name,
                              color: AppColors.adaptiveAlmostWhiteOrDeepBlue(
                                  isDark),
                            ),
                          ],
                        ),
                        if (_langCode == language.code)
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
