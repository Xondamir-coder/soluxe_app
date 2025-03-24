import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/category.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/category_tabs.dart';
import 'package:soluxe/widgets/filter_sheet.dart';
import 'package:soluxe/widgets/tile/my_tile.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class CategoriesDirectionScreen extends ConsumerStatefulWidget {
  final Category category;

  const CategoriesDirectionScreen({
    required this.category,
    super.key,
  });

  @override
  ConsumerState<CategoriesDirectionScreen> createState() =>
      _CategoriesDirectionScreenState();
}

class _CategoriesDirectionScreenState
    extends ConsumerState<CategoriesDirectionScreen> {
  final selectedSubCategory = ValueNotifier<String>('All');
  Future<Map<String, dynamic>>? _placesFuture;

  late DateTime selectedDate;
  late String selectedCategory;
  late RangeValues selectedPrice;
  late String selectedCity;

  @override
  void initState() {
    super.initState();

    selectedCategory = 'All';
    selectedDate = DateTime.now();
    selectedPrice = const RangeValues(0, 2000);
    selectedCity = 'Tashkent';

    _placesFuture = _getPlaces();

    selectedSubCategory.addListener(() {
      setState(() {
        _placesFuture = _getPlaces();
      });
    });
  }

  @override
  void dispose() {
    selectedSubCategory.dispose();
    super.dispose();
  }

  void applyFilters(Map<String, dynamic> params) {
    setState(() {
      selectedDate = DateTime.parse(params['date']);
      selectedCategory = params['category'];
      // selectedCity = params['city'];
      selectedPrice = RangeValues(
        double.parse(params['min_price'] as String),
        double.parse(params['max_price'] as String),
      );

      _fetchPlaces(
        selectedDate: selectedDate,
        selectedMainCategory: selectedCategory,
        selectedPrice: selectedPrice,
      );
    });
  }

  void _fetchPlaces({
    required DateTime selectedDate,
    required String selectedMainCategory,
    String? selectedSecondaryCategory,
    required RangeValues selectedPrice,
  }) async {
    final token = (await LocalStorageHelper.getAccountData()).token;
    setState(() {
      _placesFuture = FetchHelper.fetch(
        url: 'places',
        token: token,
        queryParams: {
          'category': widget.category.name,
          'sub_category': selectedSecondaryCategory,
          'min_price': selectedPrice.start.toInt().toString(),
          'max_price': selectedPrice.end.toInt().toString(),
          'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        },
      );
    });
  }

  Future<Map<String, dynamic>> _getPlaces() async {
    final token = (await LocalStorageHelper.getAccountData()).token;
    return FetchHelper.fetch(
      url: 'places',
      token: token,
      queryParams: {
        'category': widget.category.name,
        'sub_category': selectedSubCategory.value
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: DefaultAppbar(
        title: widget.category.name,
        iconPath: 'assets/icons/filter.svg',
        onTap: () {
          showModalBottomSheet(
            backgroundColor: AppColors.adaptiveDeepBlueOrWhite(isDark),
            context: context,
            isScrollControlled: true,
            builder: (ctx) => FilterSheet(
              mainCategories: [
                'All',
                'Concerts',
                'Exhibitions',
                'Events',
                'Others'
              ],
              secondaryCategories: [
                'All',
                'Tashkent',
                'Andijan',
                'Bukhara',
                'Fergana',
                'Samarkand'
              ],
              onApplyFilters: applyFilters,
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            if (widget.category.categories.isNotEmpty)
              ValueListenableBuilder<String>(
                valueListenable: selectedSubCategory,
                builder: (ctx, val, child) => CategoryTabs(
                  selectedCategory: selectedSubCategory.value,
                  iconPath: 'assets/icons/kitchen.svg',
                  categories: widget.category.categories,
                  onCategorySelected: (val) =>
                      setState(() => selectedSubCategory.value = val),
                ),
              ),
            FutureBuilder(
              future: _placesFuture,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if ((snapshot.data!['data'] as List).isNotEmpty) {
                    List<Place> places = [];
                    for (final data in snapshot.data!['data']) {
                      places.add(Place.fromMap(data));
                    }

                    return Expanded(
                      child: ListView.separated(
                        itemCount: places.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemBuilder: (context, index) => MyTile(
                          place: places[index],
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: Center(
                      child: MyText('No ${widget.category.name}', fontSize: 18),
                    ),
                  );
                } else {
                  return Center(
                    child: MyText(
                      (snapshot.error as Map)['body']['message'],
                      fontSize: 18,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
