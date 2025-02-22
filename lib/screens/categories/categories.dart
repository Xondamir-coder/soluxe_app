import 'package:flutter/material.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/categories/grid_categories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppbar(title: 'Categories'),
      bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 2),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            const GridCategories(),
          ],
        ),
      ),
    );
  }
}
