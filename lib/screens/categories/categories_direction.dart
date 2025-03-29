import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/filters_helper.dart';
import 'package:soluxe/models/category.dart';
import 'package:soluxe/screens/categories/categories_items.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/filter_sheet.dart';

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
  final selectedSubCategory = ValueNotifier('');
  final params = ValueNotifier<Map<String, dynamic>>({});

  int? selectedTag;
  RangeValues? selectedPrice;
  String? selectedDate;
  String? selectedCity;

  @override
  void dispose() {
    selectedSubCategory.dispose();
    params.dispose();
    super.dispose();
  }

  Future<List<String>> _getSubCategories() async {
    try {
      final filters = await fetchFilters(widget.category.name);
      final arr = filters.subCategories;
      if (arr.isEmpty) throw 'No sub categories found';
      selectedSubCategory.value = arr.first;
      return arr;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: DefaultAppbar(
        title: widget.category.name,
        iconPath: 'assets/icons/filter.svg',
        onTap: () async {
          final filters = await fetchFilters(widget.category.name);

          if (!context.mounted) return;

          showModalBottomSheet(
            backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
            context: context,
            isScrollControlled: true,
            builder: (ctx) => FilterSheet(
              onApplyFilters: (val) => (params.value = val),
              filters: filters,
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            FutureBuilder<List<String>>(
              future: _getSubCategories(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ValueListenableBuilder<String>(
                    valueListenable: selectedSubCategory,
                    builder: (context, val, child) => CategoryTabs(
                      selectedCategory: val,
                      iconPath: 'assets/icons/kitchen.svg',
                      categories: snapshot.data!,
                      onCategorySelected: (v) => selectedSubCategory.value = v,
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            ValueListenableBuilder<Map<String, dynamic>>(
              valueListenable: params,
              builder: (ctx, paramsValue, child) =>
                  ValueListenableBuilder<String>(
                valueListenable: selectedSubCategory,
                builder: (context, subCategoryValue, child) => CategoriesItems(
                  category: widget.category.name,
                  subCategory: subCategoryValue,
                  params: paramsValue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
