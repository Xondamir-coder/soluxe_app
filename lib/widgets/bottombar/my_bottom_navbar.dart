import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/categories/categories.dart';
import 'package:soluxe/screens/events.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/screens/explore.dart';
import 'package:soluxe/screens/settings.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBottomNavbar extends StatelessWidget {
  final int currentPageIndex;

  const MyBottomNavbar({
    super.key,
    required this.currentPageIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentPageIndex) return;

    final screens = [
      const HomeScreen(),
      const ExploreScreen(),
      const CategoriesScreen(),
      const EventsScreen(),
      const SettingsScreen(),
    ];

    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => screens[index]),
        (route) => false,
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => screens[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = [
      {'icon': 'home.svg', 'text': AppLocalizations.of(context)!.home},
      {'icon': 'search.svg', 'text': AppLocalizations.of(context)!.explore},
      {
        'icon': 'categories.svg',
        'text': AppLocalizations.of(context)!.categories
      },
      {'icon': 'calendar.svg', 'text': AppLocalizations.of(context)!.events},
      {'icon': 'profile.svg', 'text': AppLocalizations.of(context)!.profile},
    ];

    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.adaptiveDarkBlueOrWhite(isDark),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlue.withAlpha(8),
            spreadRadius: 0,
            blurRadius: 32,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final item = items[index];
          return MyBottomNavbarItem(
            iconPath: 'assets/icons/${item['icon']}',
            text: item['text'] as String,
            isActive: currentPageIndex == index,
            onTap: () => _onItemTapped(context, index),
          );
        }),
      ),
    );
  }
}
