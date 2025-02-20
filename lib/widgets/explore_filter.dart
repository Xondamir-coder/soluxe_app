import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/custom_date_picker.dart';
import 'package:soluxe/widgets/price_range_slider.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class ExploreFilter extends StatefulWidget {
  const ExploreFilter({super.key});

  @override
  State<ExploreFilter> createState() => _ExploreFilterState();
}

class _ExploreFilterState extends State<ExploreFilter> {
  final categories = ['All', 'Concerts', 'Exhibitions', 'Events', 'Others'];

  late DateTime selectedDate;
  late final ValueNotifier<String> selectedCategory;
  late final ValueNotifier<RangeValues> selectedPrice;

  @override
  void initState() {
    selectedCategory = ValueNotifier<String>(categories[0]);
    selectedPrice = ValueNotifier<RangeValues>(RangeValues(50, 400));
    super.initState();
  }

  @override
  void dispose() {
    selectedCategory.dispose();
    selectedPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building ExploreFilter'); // This should print only once
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          Container(
            width: 32,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.lightGrey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.deepBlue('Filter', fontSize: 20),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: SvgPicture.asset(
                  'assets/icons/x.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          ValueListenableBuilder<String>(
            valueListenable: selectedCategory,
            builder: (context, value, child) => CategoryTabs(
              selectedCategory: value,
              categories: categories,
              iconPath: 'assets/icons/date.svg',
              onCategorySelected: (val) => selectedCategory.value = val,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: MyText(
              'Price Range',
              color: AppColors.darkBrown,
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
          CustomDatePicker(
            onDateChange: (val) {
              selectedDate = val;
              print(DateFormat('yyyy-MM-dd').format(selectedDate));
            },
          ),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: GreyOutlinedButton(
                  'Cancel',
                  onTap: () {},
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
    );
  }
}
