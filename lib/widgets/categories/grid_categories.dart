import 'package:flutter/material.dart';
import 'package:soluxe/data/categories.dart';
import 'package:soluxe/widgets/categories/grid_categories_item.dart';

class GridCategories extends StatelessWidget {
  const GridCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 162 / 146,
          crossAxisCount: 2,
          crossAxisSpacing: 19,
          mainAxisSpacing: 19,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) => GridCategoriesItem(
          category: categories[index],
        ),
      ),
    );
  }
}
