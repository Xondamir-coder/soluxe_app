import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/place/tag.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class HotelsFilterTags extends StatefulWidget {
  final ValueChanged<int> onTagSelected;

  const HotelsFilterTags({super.key, required this.onTagSelected});

  @override
  State<HotelsFilterTags> createState() => _HotelsFilterTagsState();
}

class _HotelsFilterTagsState extends State<HotelsFilterTags> {
  int _selectedTagId = 0;
  var _isLoading = true;
  final List<Tag> _tags = [];

  void _fetchTags() async {
    try {
      final token = (await LocalStorageHelper.getAccountData()).token;
      final body = await FetchHelper.fetch(
        url: 'tags',
        token: token,
      );

      if ((body['data'] as List).isEmpty) return;

      setState(() {
        for (final data in body['data']) {
          _tags.add(Tag.fromMap(data));
        }
        _selectedTagId = _tags[0].id!;
      });
    } catch (e) {
      rethrow;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget content = CircularProgressIndicator.adaptive();
    if (!_isLoading && _tags.isNotEmpty) {
      return SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (ctx, index) => const SizedBox(width: 10),
          itemBuilder: (ctx, index) {
            final tag = _tags[index];
            final isSelected = _selectedTagId == tag.id;
            final color = isSelected
                ? Colors.white
                : AppColors.adaptiveAccentWhiteOrVeryDarkBrown(isDark);

            return GestureDetector(
              onTap: () {
                // Update UI
                setState(() => _selectedTagId = tag.id!);

                // Pass to the parent
                widget.onTagSelected(_selectedTagId);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
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
                          tag.icon!,
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
                      child: Text(
                          (AppLocalizations.of(context)!.localeName == 'en'
                                  ? tag.nameEn
                                  : tag.nameZh) ??
                              'N/A'),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _tags.length,
        ),
      );
    } else if (!_isLoading && _tags.isEmpty) {
      content = MyText.warmPrimary(
        'No tags found',
        fontSize: 14,
      );
    }
    return content;
  }
}
