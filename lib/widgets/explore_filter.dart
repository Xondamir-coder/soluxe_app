import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class ExploreFilter extends StatefulWidget {
  const ExploreFilter({super.key});

  @override
  State<ExploreFilter> createState() => _ExploreFilterState();
}

class _ExploreFilterState extends State<ExploreFilter> {
  var selectedCategory = '';
  final categories = ['All', 'Concerts', 'Exhibitions', 'Events', 'Others'];

  @override
  void initState() {
    selectedCategory = categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building');
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          CategoryTabs(
            selectedCategory: selectedCategory,
            categories: categories,
            withIcons: true,
            onCategorySelected: (val) {
              setState(() => selectedCategory = val);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                'Price Range',
                color: AppColors.darkBrown,
                fontWeight: FontWeight.w700,
              ),
            ],
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
          )
        ],
      ),
    );
  }
}
