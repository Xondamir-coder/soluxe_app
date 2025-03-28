import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/events_provider.dart';
import 'package:soluxe/providers/hotels_provider.dart';
import 'package:soluxe/screens/events.dart';
import 'package:soluxe/screens/hotels.dart';
import 'package:soluxe/screens/notifications.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/event/event_card.dart';
import 'package:soluxe/widgets/hotel/hotels_item.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/section_header.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var query = '';
  var selectedCategory = '';
  final categories = [
    'Concerts',
    'Hotels',
    'Restaurants',
    'Theater',
    'Example'
  ];

  @override
  void initState() {
    selectedCategory = categories[0];
    super.initState();
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NotificationsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final events = ref.watch(eventsProvider);
    final hotels = ref.watch(hotelsProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 0),
        appBar: AppBar(
          backgroundColor: AppColors.adaptiveDeepBlueOrCreamWhite(isDark),
          actions: [
            ScaleUpWidget.fade(
              child: Container(
                width: 44,
                height: 44,
                margin: EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () => _navigateToNotifications(context),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.adaptiveAccentBlueOrWhite(
                      isDark,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors.adaptiveAccentWhiteOrDeepBlue(isDark),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: SlideInWidget.fade(
            begin: const Offset(-0.5, 0),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  'Find events near',
                  color: AppColors.adaptiveDarkGreyOrAccentYellow(isDark),
                ),
                MyText(
                  'Uzbekistan',
                  fontSize: 18,
                  color: AppColors.adaptiveGreyOrWarmBrown(isDark),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 27,
              bottom: 16,
            ),
            child: Column(
              spacing: 10,
              children: [
                Column(
                  spacing: 10,
                  children: [
                    MySearchBar(
                      label: 'Search events',
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
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    SectionHeader(
                      title: 'Upcoming events',
                      totalDelay: 300,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const EventsScreen(),
                        ),
                      ),
                    ),
                    SlideInWidget.fade(
                      begin: const Offset(0, 0.25),
                      delay: 500,
                      child: SizedBox(
                        height: 290,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            final event = events[index];
                            return EventCard(event: event);
                          },
                          itemCount: events.length,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    SectionHeader(
                      title: 'Hotels',
                      totalDelay: 500,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const HotelsScreen(),
                        ),
                      ),
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        for (var i = 0;
                            i < (hotels.length < 4 ? hotels.length : 4);
                            i++)
                          HotelsItem(
                            hotel: hotels[i],
                            delay: i * 150 + 500,
                          ),
                      ],
                    ),
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
