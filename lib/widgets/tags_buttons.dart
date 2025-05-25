import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/place/tag.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagsButtons extends StatelessWidget {
  final List<Tag> tags;
  final Function(Tag) onTagSelected;
  final Tag selectedTag;
  final Color? bgColor;

  const TagsButtons({
    super.key,
    required this.selectedTag,
    required this.tags,
    required this.onTagSelected,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 45, // Adjust height as needed
      child: ListView.separated(
        separatorBuilder: (ctx, index) => const SizedBox(width: 10),
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          bool isSelected = tag.id == selectedTag.id;
          final backColor = isSelected
              ? AppColors.primary
              : bgColor ?? AppColors.adaptiveDarkBlueOrWhite(isDark);
          final textColor = isSelected
              ? Colors.white
              : AppColors.adaptiveSoftWhiteOrDarkBlue(isDark);

          return ScaleUpWidget.fade(
            beginScale: 0.75,
            delay: index * 150 + 150,
            child: GestureDetector(
              onTap: () => onTagSelected(tag),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                  decoration: BoxDecoration(
                    color: backColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(107, 114, 128, 0.04),
                        blurRadius: 10,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    spacing: 6,
                    children: [
                      if (isSelected)
                        SvgPicture.asset(
                          'assets/icons/flash.svg',
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      if (!isSelected)
                        SvgPicture.string(
                          tag.icon ?? '',
                          colorFilter: ColorFilter.mode(
                            AppColors.adaptiveAccentWhiteOrDarkBrown(isDark),
                            BlendMode.srcIn,
                          ),
                          width: 18,
                          height: 18,
                        ),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: GoogleFonts.instrumentSans(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: textColor,
                        ),
                        child: Text(
                            (AppLocalizations.of(context)!.localeName == 'en'
                                    ? tag.nameEn
                                    : tag.nameZh) ??
                                'Unknown'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
