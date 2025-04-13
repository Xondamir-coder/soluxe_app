import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelsFilterRating extends StatefulWidget {
  final ValueChanged<int> onRatingChanged;

  const HotelsFilterRating({super.key, required this.onRatingChanged});

  @override
  State<HotelsFilterRating> createState() => _HotelsFilterRatingState();
}

class _HotelsFilterRatingState extends State<HotelsFilterRating> {
  final _selectedRatingNotifier = ValueNotifier<int>(5);

  @override
  void dispose() {
    _selectedRatingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            AppLocalizations.of(context)!.filterByRating,
            color: AppColors.adaptiveGreyOrDarkBrown(isDark),
            fontWeight: FontWeight.w700,
          ),
          ValueListenableBuilder(
            valueListenable: _selectedRatingNotifier,
            builder: (context, value, child) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final ratingValue = 5 - index;
                  final isSelected =
                      _selectedRatingNotifier.value == ratingValue;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRatingNotifier.value = ratingValue;
                      });
                      widget.onRatingChanged(_selectedRatingNotifier.value);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? AppColors.yellow
                              : AppColors.adaptivAccentBlueOrLightGrey(isDark),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.adaptiveTransparentOrWhite(isDark),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(ratingValue, (starIndex) {
                          return TweenAnimationBuilder<Color?>(
                            tween: ColorTween(
                              begin: AppColors.grey, // Default color
                              end: isSelected
                                  ? AppColors.yellow
                                  : AppColors.adaptiveAccentWhiteOrGrey(
                                      isDark), // Animated color
                            ),
                            duration: const Duration(milliseconds: 300),
                            builder: (context, color, child) {
                              return SvgPicture.asset(
                                'assets/icons/star.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  color!,
                                  BlendMode.srcIn,
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
