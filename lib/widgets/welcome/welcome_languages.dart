import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/languages.dart';
import 'package:soluxe/helpers/preference_helper.dart';

class WelcomeLanguages extends StatefulWidget {
  final void Function() onTap;

  const WelcomeLanguages({super.key, required this.onTap});

  @override
  State<WelcomeLanguages> createState() => _WelcomeLanguagesState();
}

class _WelcomeLanguagesState extends State<WelcomeLanguages> {
  String? _selectedLanguageCode;

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Call async function
  }

  Future<void> _loadLanguage() async {
    _selectedLanguageCode = await PreferenceHelper.getLanguage();
    setState(() {}); // Update UI after fetching language
  }

  void _setLang(String code) async {
    setState(() {
      _selectedLanguageCode = code;
    });
    await PreferenceHelper.saveLanguage(code);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        spacing: 16,
        children: [
          for (final language in AppLanguages.languages)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.softWhite, width: 1),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
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
                    groupValue: _selectedLanguageCode,
                    dense: true,
                    onChanged: (value) {
                      _setLang(value!);
                      widget.onTap();
                    },
                    title: Row(
                      children: [
                        language.icon,
                        SizedBox(width: 16),
                        Text(
                          language.name,
                          style: GoogleFonts.instrumentSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepBlue,
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
