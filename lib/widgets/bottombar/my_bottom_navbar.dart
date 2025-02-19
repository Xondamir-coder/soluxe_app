import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/events.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/screens/explore.dart';
import 'package:soluxe/screens/settings.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar_item.dart';

class MyBottomNavbar extends StatelessWidget {
  final int currentPageIndex;

  const MyBottomNavbar({
    super.key,
    required this.currentPageIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentPageIndex) return;

    Widget screen;
    switch (index) {
      case 0:
        //  Home screen should reset navigation stack
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const HomeScreen()),
          (route) => false, // Removes all previous routes
        );
        return;
      case 1:
        screen = const ExploreScreen();
        break;
      case 3:
        screen = const EventsScreen();
        break;
      case 4:
        screen = const SettingsScreen();
        break;
      default:
        return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlue.withValues(alpha: 0.03),
            spreadRadius: 0,
            blurRadius: 32,
            offset: Offset(0, -8), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyBottomNavbarItem(
            iconPath: 'assets/icons/home.svg',
            text: 'Home',
            isActive: currentPageIndex == 0,
            onTap: () => _onItemTapped(context, 0),
          ),
          MyBottomNavbarItem(
            iconPath: 'assets/icons/search.svg',
            text: 'Explore',
            isActive: currentPageIndex == 1,
            onTap: () => _onItemTapped(context, 1),
          ),
          MyBottomNavbarItem(
            iconPath: 'assets/icons/categories.svg',
            text: 'Categories',
            isActive: currentPageIndex == 2,
            onTap: () => _onItemTapped(context, 2),
          ),
          MyBottomNavbarItem(
            iconPath: 'assets/icons/calendar.svg',
            text: 'Events',
            isActive: currentPageIndex == 3,
            onTap: () => _onItemTapped(context, 3),
          ),
          MyBottomNavbarItem(
            iconPath: 'assets/icons/profile.svg',
            text: 'Profile',
            isActive: currentPageIndex == 4,
            onTap: () => _onItemTapped(context, 4),
          ),
        ],
      ),
    );
  }
}
