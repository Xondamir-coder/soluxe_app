import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/events.dart';
import 'package:soluxe/data/hotels.dart';
import 'package:soluxe/screens/notifications.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/home/home_event_card.dart';
import 'package:soluxe/widgets/home/home_hotel_card.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  OutlineInputBorder _buildInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
    );
  }

  void _searchEvents(String query) {
    print(query);
  }

  void _selectCategory(String categoryName) {
    print(categoryName);
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
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 27,
          bottom: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              Column(
                spacing: 10,
                children: [
                  TextField(
                    onChanged: _searchEvents,
                    style: GoogleFonts.instrumentSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.deepBlue,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 14,
                          top: 14,
                          bottom: 14,
                          left: 20,
                        ),
                        child: SvgPicture.asset('assets/icons/search.svg'),
                      ),
                      labelText: 'Search events',
                      labelStyle: GoogleFonts.instrumentSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: _buildInputBorder(Colors.white),
                      enabledBorder: _buildInputBorder(Colors.white),
                      focusedBorder: _buildInputBorder(AppColors.accentYellow),
                    ),
                  ),
                  CategoryTabs(
                    categories: [
                      'Concerts',
                      'Hotels',
                      'Restaurants',
                      'Theater',
                      'Example'
                    ],
                    onCategorySelected: _selectCategory,
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
                        icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
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
                        icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
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
    );
  }
}
