import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/filters_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/widgets/bottombar/my_bottom_navbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/filter_sheet.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/tile/my_tile.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var _selectedCategory = Constants.categories[0];
  var _query = '';
  var items = [];
  var params = {};
  var _isLoading = false;

  Future<void> _fetchPlaces() async {
    setState(() {
      _isLoading = true;
    });

    // Clear array
    items = [];

    final token = (await LocalStorageHelper.getAccountData()).token;

    final data = (await FetchHelper.fetch(
      url: 'places',
      token: token,
      queryParams: {
        ...params,
        'category': _selectedCategory,
        if (_query.isNotEmpty) 'search': _query,
      },
    ) as Map)['data'];

    setState(() {
      for (final item in data) {
        if (_selectedCategory == 'Events') {
          items.add(Event.fromMap(item));
        } else {
          items.add(Place.fromMap(item));
        }
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  void _openFilters(BuildContext context, bool isDark) async {
    final filters = await fetchFilters(_selectedCategory);

    if (!context.mounted) return;

    showModalBottomSheet(
      backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FilterSheet(
        onApplyFilters: (val) {
          params = val;
          _fetchPlaces();
        },
        filters: filters,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
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
                      categories: Constants.categories,
                      onCategorySelected: (val) {
                        setState(() {
                          _selectedCategory = val;
                        });
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
                    if (_isLoading && items.isEmpty)
                      Center(child: CircularProgressIndicator.adaptive()),
                    if (!_isLoading && items.isEmpty)
                      const MyText.warmBrown('No results found'),
                    if (items.isNotEmpty)
                      for (final place in items) MyTile(place: place),
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
