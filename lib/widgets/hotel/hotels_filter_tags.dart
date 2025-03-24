import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/tags_provider.dart';

class HotelsFilterTags extends ConsumerStatefulWidget {
  final ValueChanged<int> onAmenitySelected;

  const HotelsFilterTags({super.key, required this.onAmenitySelected});

  @override
  ConsumerState<HotelsFilterTags> createState() => _HotelsFilterTagsState();
}

class _HotelsFilterTagsState extends ConsumerState<HotelsFilterTags> {
  int _selectedTagId = 0;

  @override
  void initState() {
    _selectedTagId = ref.read(tagsProvider).first.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tags = ref.watch(tagsProvider);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (ctx, index) => const SizedBox(width: 10),
        itemBuilder: (ctx, index) {
          final tag = tags[index];
          final isSelected = _selectedTagId == tag.id;
          final color = isSelected
              ? Colors.white
              : AppColors.adaptiveAccentWhiteOrVeryDarkBrown(isDark);

          return GestureDetector(
            onTap: () {
              // Update UI
              setState(() => _selectedTagId = tag.id);

              // Pass to the parent
              widget.onAmenitySelected(_selectedTagId);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentYellow
                    : AppColors.adaptiveDarkBlueOrLightGrey(isDark),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                spacing: 6,
                children: [
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: AppColors.veryDarkBrown,
                      end: color,
                    ),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, color, child) {
                      return SvgPicture.string(
                        tag.icon,
                        width: 15,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                          color ?? AppColors.veryDarkBrown,
                          BlendMode.srcIn,
                        ),
                      );
                    },
                  ),
                  AnimatedDefaultTextStyle(
                    style: GoogleFonts.instrumentSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                    duration: const Duration(milliseconds: 300),
                    child: Text(tag.nameEn),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: tags.length,
      ),
    );
  }
}
