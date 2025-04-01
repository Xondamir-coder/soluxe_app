import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var query = '';
  var selectedCategory = '';

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
                  AppLocalizations.of(context)!.findEventsNear,
                  color: AppColors.adaptiveDarkGreyOrAccentYellow(isDark),
                ),
                MyText(
                  AppLocalizations.of(context)!.uzbekistan,
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
                      label: AppLocalizations.of(context)!.searchEvents,
                      onSearch: (val) {
                        query = val;
                      },
                    ),
                    CategoryTabs(
                      selectedCategory: selectedCategory,
                      categories:
                          AppLocalizations.of(context)!.localeName == 'en'
                              ? Constants.categoriesEn
                              : Constants.categoriesZh,
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
                      title: AppLocalizations.of(context)!.upcomingEvents,
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
                            final sublistedEvents = events.length > 4
                                ? events.sublist(0, 4)
                                : events;
                            final event = sublistedEvents[index];
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
                      title: AppLocalizations.of(context)!.hotels,
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
