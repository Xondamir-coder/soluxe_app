import 'package:flutter/material.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/data/categories.dart';
import 'package:soluxe/models/category.dart';
import 'package:soluxe/widgets/categories/grid_categories_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GridCategories extends StatelessWidget {
  const GridCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final code = AppLocalizations.of(context)!.localeName;
    final List<Category> items = [];
    for (var i = 0; i < categories.length; i++) {
      final arr =
          code == 'zh' ? Constants.categoriesZh : Constants.categoriesEn;
      items.add(
        Category(
          name: arr.sublist(1)[i],
          iconPath: categories[i].iconPath,
          color: categories[i].color,
          apiName: categories[i].apiName,
        ),
      );
    }

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 162 / 146,
          crossAxisCount: 2,
          crossAxisSpacing: 19,
          mainAxisSpacing: 19,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => GridCategoriesItem(
          category: items[index],
        ),
      ),
    );
  }
}
