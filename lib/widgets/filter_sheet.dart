import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/date_pickers/expanded_date_picker.dart';
import 'package:soluxe/widgets/drag_handle.dart';
import 'package:soluxe/widgets/price_range_slider.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class FilterSheet extends StatefulWidget {
  final List<String> mainCategories;
  final List<String> secondaryCategories;

  const FilterSheet({
    super.key,
    required this.mainCategories,
    this.secondaryCategories = const [],
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late ValueNotifier<DateTime> selectedDate;
  late final ValueNotifier<String> selectedMainCategory;
  late final ValueNotifier<String> selectedSecondaryCategory;
  late final ValueNotifier<RangeValues> selectedPrice;

  @override
  void initState() {
    selectedMainCategory = ValueNotifier<String>(widget.mainCategories[0]);
    selectedPrice = ValueNotifier<RangeValues>(RangeValues(50, 400));
    selectedDate = ValueNotifier<DateTime>(DateTime.now());
    if (widget.secondaryCategories.isNotEmpty) {
      selectedSecondaryCategory =
          ValueNotifier<String>(widget.secondaryCategories[0]);
    }

    super.initState();
  }

  @override
  void dispose() {
    selectedMainCategory.dispose();
    selectedPrice.dispose();
    super.dispose();
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
              ValueListenableBuilder<String>(
                valueListenable: selectedMainCategory,
                builder: (context, value, child) => CategoryTabs(
                  selectedCategory: value,
                  categories: widget.mainCategories,
                  iconPath: 'assets/icons/date.svg',
                  bgColor: AppColors.adaptiveDarkBlueOrLightGrey(isDark),
                  onCategorySelected: (val) => selectedMainCategory.value = val,
                ),
              ),
              if (widget.secondaryCategories.isNotEmpty)
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'Country',
                      color: AppColors.adaptiveGreyOrDarkBrown(isDark),
                      fontWeight: FontWeight.w700,
                    ),
                    ValueListenableBuilder<String>(
                      valueListenable: selectedSecondaryCategory,
                      builder: (context, value, child) => CategoryTabs(
                        selectedCategory: value,
                        categories: widget.secondaryCategories,
                        bgColor: AppColors.adaptiveDarkBlueOrLightGrey(isDark),
                        onCategorySelected: (val) =>
                            selectedSecondaryCategory.value = val,
                      ),
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
              ValueListenableBuilder<RangeValues>(
                valueListenable: selectedPrice,
                builder: (context, value, child) => SizedBox(
                  height: 80,
                  child: PriceRangeSlider(
                    selectedPrice: value,
                    onSelectPrice: (val) => selectedPrice.value = val,
                  ),
                ),
              ),
              ValueListenableBuilder<DateTime>(
                valueListenable: selectedDate,
                builder: (context, value, child) => ExpandedDatePicker(
                  date: selectedDate.value,
                  darkBlueBgColor: true,
                  onDateChange: (val) {
                    selectedDate.value = val;
                    print(DateFormat('yyyy-MM-dd').format(selectedDate.value));
                  },
                ),
              ),
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
                      onTap: () {},
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
