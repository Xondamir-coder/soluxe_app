import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/filters.dart';
import 'package:soluxe/models/place/tag.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/date_pickers/expanded_date_picker.dart';
import 'package:soluxe/widgets/drag_handle.dart';
import 'package:soluxe/widgets/price_range_slider.dart';
import 'package:soluxe/widgets/tags_buttons.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class FilterSheet extends StatefulWidget {
  final Filters filters;
  final void Function(Map<String, dynamic>) onApplyFilters;

  const FilterSheet({
    super.key,
    required this.filters,
    required this.onApplyFilters,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  Tag? selectedTag;
  String? selectedCity;
  var selectedPrice = const RangeValues(0, 2000);
  var selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedTag =
        widget.filters.tags.isNotEmpty ? widget.filters.tags.first : null;
    selectedCity =
        widget.filters.cities.isNotEmpty ? widget.filters.cities.first : null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              const DragHandle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    'Filter',
                    fontSize: 20,
                    color: AppColors.adaptiveGreyOrDeepBlue(isDark),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: SvgPicture.asset(
                      isDark ? 'assets/icons/dark-x.svg' : 'assets/icons/x.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              if (widget.filters.tags.isNotEmpty)
                TagsButtons(
                  selectedTag: selectedTag!,
                  tags: widget.filters.tags,
                  bgColor: AppColors.adaptiveDarkBlueOrLightGrey(isDark),
                  onTagSelected: (val) {
                    setState(() {
                      selectedTag = val;
                    });
                  },
                ),
              if (widget.filters.cities.isNotEmpty)
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'Country',
                      color: AppColors.adaptiveGreyOrDarkBrown(isDark),
                      fontWeight: FontWeight.w700,
                    ),
                    CategoryTabs(
                      selectedCategory: selectedCity!,
                      categories: widget.filters.cities,
                      bgColor: AppColors.adaptiveDarkBlueOrLightGrey(isDark),
                      onCategorySelected: (val) {
                        setState(() {
                          selectedCity = val;
                        });
                      },
                    ),
                  ],
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  'Price Range',
                  color: AppColors.adaptiveGreyOrDarkBrown(isDark),
                  fontWeight: FontWeight.w700,
                ),
              ),
              PriceRangeSlider(
                selectedPrice: selectedPrice,
                onSelectPrice: (val) {
                  setState(() {
                    selectedPrice = val;
                  });
                },
              ),
              ExpandedDatePicker(
                  date: selectedDate,
                  darkBlueBgColor: true,
                  onDateChange: (val) {
                    setState(() {
                      selectedDate = DateTime.parse(val);
                    });
                  }),
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: GreyOutlinedButton(
                      'Cancel',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: YellowButton(
                      'Apply',
                      onTap: () {
                        final params = {
                          'working_date':
                              DateFormat('yyyy-MM-dd').format(selectedDate),
                          if (selectedTag != null)
                            'tag': selectedTag!.id.toString(),
                          'min_price': selectedPrice.start.toInt().toString(),
                          'max_price': selectedPrice.end.toInt().toString(),
                          if (selectedCity != null) 'city': selectedCity!,
                        };
                        widget.onApplyFilters(params);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
