import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/locale_provider.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final typesEn = ['Hostel', 'Hotel'];
final typesZh = ['旅館', '酒店'];

class HotelsFilterType extends ConsumerStatefulWidget {
  final ValueChanged<String> onTypeChanged;

  const HotelsFilterType({required this.onTypeChanged, super.key});

  @override
  ConsumerState<HotelsFilterType> createState() => _HotelsFilterTypeState();
}

class _HotelsFilterTypeState extends ConsumerState<HotelsFilterType> {
  final _selectedTypeNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _selectedTypeNotifier.value =
        (ref.read(localeProvider).languageCode == 'zh' ? typesZh : typesEn)
            .first;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          AppLocalizations.of(context)!.filterByType,
          color: AppColors.adaptiveGreyOrDarkBrown(isDark),
          fontWeight: FontWeight.w700,
        ),
        ValueListenableBuilder(
          valueListenable: _selectedTypeNotifier,
          builder: (context, value, child) => Row(
            spacing: 10,
            children: [
              for (final type
                  in AppLocalizations.of(context)!.localeName == 'zh'
                      ? typesZh
                      : typesEn)
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() => _selectedTypeNotifier.value = type);
                        widget.onTypeChanged(_selectedTypeNotifier.value);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(vertical: 13.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: type == _selectedTypeNotifier.value
                                ? AppColors.accentYellow
                                : AppColors.adaptivAccentBlueOrLightGrey(
                                    isDark),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: type == _selectedTypeNotifier.value
                                  ? SvgPicture.asset('assets/icons/check.svg')
                                  : Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: AppColors
                                            .adaptiveAccentBlueOrSoftWhite(
                                                isDark),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            ),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: GoogleFonts.instrumentSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: type == _selectedTypeNotifier.value
                                    ? AppColors.accentYellow
                                    : AppColors.adaptiveAlmostWhiteOrDeepBlue(
                                        isDark),
                              ),
                              child: Text(type),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
