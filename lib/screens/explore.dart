// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/filter_sheet.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/tile/my_tile.dart';
import 'package:soluxe/widgets/tile/my_tile_event.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final categories = [
    'All',
    'Hotels',
    'Restaurants',
    'Historical Places',
    'Events'
  ];
  var _selectedCategory = '';
  var _query = '';
  var items = [];

  late DateTime _selectedDate;
  late String _selectedMainCategory;
  late RangeValues _selectedPrice;
  late String _selectedCity;

  @override
  void initState() {
    _selectedCategory = categories[0];
    _selectedMainCategory = 'All';
    _selectedDate = DateTime.now();
    _selectedPrice = const RangeValues(0, 2000);
    _selectedCity = 'Tashkent';

    super.initState();
  }

  void applyFilters(Map<String, dynamic> params) {
    setState(() {
      _selectedDate = DateTime.parse(params['date']);
      // _selectedCategory = params['category'];
      // selectedCity = params['city'];
      _selectedPrice = RangeValues(
        double.parse(params['min_price'] as String),
        double.parse(params['max_price'] as String),
      );

      _fetchPlaces();
    });
  }

  Future<void> _fetchPlaces() async {
    final token = (await LocalStorageHelper.getAccountData()).token;

    final url = _selectedCategory == 'Events' ? 'events' : 'places';
    final data = (await FetchHelper.fetch(
      url: url,
      token: token,
      queryParams: {
        'category': _selectedCategory,
        'search': _query,
        'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
        'min_price': _selectedPrice.start.toInt().toString(),
        'max_price': _selectedPrice.end.toInt().toString(),
      },
    ) as Map)['data'];

    // Clear array
    items = [];

    setState(() {
      for (final item in data) {
        if (_selectedCategory == 'Events') {
          items.add(Event.fromMap(item));
        } else {
          items.add(Place.fromMap(item));
        }
      }
    });
  }

  void selectInput({required String name, required String val}) {
    setState(() {
      switch (name) {
        case 'date':
          _selectedDate = DateTime.parse(val);
          break;
        case 'mainCategory':
          _selectedMainCategory = val;
          break;
        case 'city':
          _selectedCity = val;
          break;
        case 'price':
          _selectedPrice = RangeValues(
            double.parse(val.split('-')[0]),
            double.parse(val.split('-')[1]),
          );
          break;
        default:
      }
    });
  }

  void _openFilters(BuildContext context, bool isDark) {
    showModalBottomSheet(
      backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FilterSheet(
        mainCategories: const ['All', 'Concerts', "Exhibitions", 'Hotels'],
        onApplyFilters: applyFilters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: const MyBottomNavbar(currentPageIndex: 1),
        appBar: DefaultAppbar(
          title: 'Explore',
          iconPath: 'assets/icons/filter.svg',
          onTap: () => _openFilters(context, isDark),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              spacing: 24,
              children: [
                Column(
                  spacing: 16,
                  children: [
                    MySearchBar(
                      label: 'Search...',
                      onSearch: (val) {
                        _query = val;
                        _fetchPlaces();
                      },
                    ),
                    CategoryTabs(
                      selectedCategory: _selectedCategory,
                      categories: categories,
                      onCategorySelected: (val) {
                        setState(() => _selectedCategory = val);
                        _fetchPlaces();
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: MyText.deepBlue(
                        'Popular Searches',
                        fontSize: 16,
                      ),
                    ),
                    if (items.isEmpty)
                      const MyText.deepBlue('No results found'),
                    if (_selectedCategory == 'Events') ...[
                      for (final event in items) MyTileEvent(event: event),
                    ],
                    if (_selectedCategory != 'Events') ...[
                      for (final place in items) MyTile(place: place),
                    ]
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
