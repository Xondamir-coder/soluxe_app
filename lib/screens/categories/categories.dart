import 'package:flutter/material.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/categories/grid_categories.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(title: AppLocalizations.of(context)!.categories),
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
