import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/languages.dart';

class HomeLanguages extends StatefulWidget {
  final void Function() onTap;

  const HomeLanguages({super.key, required this.onTap});

  @override
  State<HomeLanguages> createState() => _HomeLanguagesState();
}

class _HomeLanguagesState extends State<HomeLanguages> {
  String? _selectedLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        spacing: 16,
        children: AppLanguages.languages
            .map(
              (language) => Container(
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
                      splashColor:
                          AppColors.accentYellow.withValues(alpha: 0.75),
                      highlightColor:
                          AppColors.accentYellow.withValues(alpha: 0.5),
                    ),
                    child: RadioListTile(
                      contentPadding: EdgeInsets.only(
                          left: 16, right: 9, top: 9, bottom: 9),
                      value: language.code,
                      groupValue: _selectedLanguageCode,
                      dense: true,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguageCode = value!;
                        });
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
            )
            .toList(),
      ),
    );
  }
}
