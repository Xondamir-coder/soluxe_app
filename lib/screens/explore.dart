import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/hotels.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/filter_sheet.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/tile/my_tile.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final categories = [
    'All',
    'Hotels',
    'Restaurants',
    'Historical Places',
    'Events'
  ];
  var selectedCategory = '';
  var query = '';

  @override
  void initState() {
    selectedCategory = categories[0];
    super.initState();
  }

  void _openFilters(BuildContext context, bool isDark) {
    showModalBottomSheet(
      backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const FilterSheet(
        mainCategories: ['All', 'Concerts', "Exhibitions", 'Hotels'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 1),
        appBar: DefaultAppbar(
          title: 'Explore',
          iconPath: 'assets/icons/filter.svg',
          onTap: () => _openFilters(context, isDark),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              spacing: 24,
              children: [
                Column(
                  spacing: 16,
                  children: [
                    MySearchBar(
                      label: 'Search...',
                      onSearch: (val) {
                        query = val;
                      },
                    ),
                    CategoryTabs(
                      selectedCategory: selectedCategory,
                      categories: categories,
                      onCategorySelected: (val) {
                        setState(() => selectedCategory = val);
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    MyText.deepBlue(
                      'Popular Searches',
                      fontSize: 16,
                    ),
                    for (final hotel in hotels)
                      MyTile(places: hotel, dateOnImage: true, isStars: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
