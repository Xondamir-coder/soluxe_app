import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/events.dart';
import 'package:soluxe/data/hotels.dart';
import 'package:soluxe/screens/notifications.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/home/home_event_card.dart';
import 'package:soluxe/widgets/home/home_hotel_card.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    print('building home');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 0),
        appBar: AppBar(
          backgroundColor: AppColors.creamWhite,
          actions: [
            Container(
              width: 44,
              height: 44,
              margin: EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () => _navigateToNotifications(context),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: SvgPicture.asset('assets/icons/notification.svg'),
              ),
            ),
          ],
          title: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                'Find events near',
                color: AppColors.accentYellow,
              ),
              MyTitle(
                'Uzbekistan',
                fontSize: 18,
                letterSpacing: 0,
              ),
            ],
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
                  spacing: 5,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTitle(
                          'Upcoming events',
                          fontSize: 16,
                          letterSpacing: 0,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          label: MyText(
                            'See All',
                            color: AppColors.accentYellow,
                          ),
                          style: TextButton.styleFrom(
                            overlayColor: AppColors.grey,
                          ),
                          iconAlignment: IconAlignment.end,
                          icon:
                              SvgPicture.asset('assets/icons/arrow-right.svg'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          final event = events[index];
                          return HomeEventCard(event: event);
                        },
                        itemCount: events.length,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 5,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTitle(
                          'Hotels',
                          fontSize: 16,
                          letterSpacing: 0,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          label: MyText(
                            'See All',
                            color: AppColors.accentYellow,
                          ),
                          style: TextButton.styleFrom(
                            overlayColor: AppColors.grey,
                          ),
                          iconAlignment: IconAlignment.end,
                          icon:
                              SvgPicture.asset('assets/icons/arrow-right.svg'),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        for (final hotel in hotels) HomeHotelCard(hotel: hotel),
                      ],
                    )
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
