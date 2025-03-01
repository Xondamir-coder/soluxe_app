import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/restaurants.dart';
import 'package:soluxe/models/category.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/filter_sheet.dart';
import 'package:soluxe/widgets/tile/my_tile.dart';

class CategoriesDirectionScreen extends StatefulWidget {
  final Category category;

  const CategoriesDirectionScreen({
    required this.category,
    super.key,
  });

  @override
  State<CategoriesDirectionScreen> createState() =>
      _CategoriesDirectionScreenState();
}

class _CategoriesDirectionScreenState extends State<CategoriesDirectionScreen> {
  var selectedCategory = '';

  @override
  void initState() {
    if (widget.category.categories.isEmpty) return;
    selectedCategory = widget.category.categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: DefaultAppbar(
        title: widget.category.name,
        iconPath: 'assets/icons/filter.svg',
        onTap: () {
          showModalBottomSheet(
            backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
            context: context,
            isScrollControlled: true,
            builder: (ctx) => FilterSheet(
              mainCategories: [
                'All',
                'Concerts',
                'Exhibitions',
                'Events',
                'Others'
              ],
              secondaryCategories: [
                'All',
                'Tashkent',
                'Andijan',
                'Bukhara',
                'Fergana',
                'Samarkand'
              ],
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            if (widget.category.categories.isNotEmpty)
              CategoryTabs(
                selectedCategory: selectedCategory,
                iconPath: 'assets/icons/kitchen.svg',
                categories: widget.category.categories,
                onCategorySelected: (val) =>
                    setState(() => selectedCategory = val),
              ),
            Expanded(
              child: ListView.separated(
                itemCount: restaurants.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) => MyTile(
                  places: restaurants[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
