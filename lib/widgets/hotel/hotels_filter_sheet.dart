import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/widgets/date_pickers/expanded_date_picker.dart';
import 'package:soluxe/widgets/drag_handle.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_amenities.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_buttons.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_rating.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_type.dart';
import 'package:soluxe/widgets/price_range_slider.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/constants/colors.dart';

class HotelsFilterSheet extends StatefulWidget {
  const HotelsFilterSheet({super.key});

  @override
  State<HotelsFilterSheet> createState() => _HotelsFilterSheetState();
}

class _HotelsFilterSheetState extends State<HotelsFilterSheet> {
  // UI update managed in children separately
  var _selectedAmenityName = 'All';
  var _selectedType = 'Hotel';
  var _selectedRating = 5;

  // UI update managed in parent
  var selectedDate = ValueNotifier<DateTime>(DateTime.now());
  var selectedPrice = ValueNotifier<RangeValues>(RangeValues(50, 400));

  void applyFilters() {
    print('applying filters');
    print('Selected Amenity: $_selectedAmenityName');
    print('Selected Type: $_selectedType');
    print('Selected Rating: $_selectedRating');
    print('Selected Date: ${selectedDate.value}');
    print(
        'Selected Price Range: ${selectedPrice.value.start} - ${selectedPrice.value.end}');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            const DragHandle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  'Filter',
                  fontSize: 20,
                  color: AppColors.adaptiveGreyOrDeepBlue(isDark),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: SvgPicture.asset(
                    isDark ? 'assets/icons/dark-x.svg' : 'assets/icons/x.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            HotelsFilterAmenities(
              onAmenitySelected: (value) => _selectedAmenityName = value,
            ),
            HotelsFilterType(onTypeChanged: (value) => _selectedType = value),
            HotelsFilterRating(
              onRatingChanged: (value) => _selectedRating = value,
            ),
            ValueListenableBuilder(
              valueListenable: selectedPrice,
              builder: (context, value, child) => PriceRangeSlider(
                selectedPrice: selectedPrice.value,
                onSelectPrice: (value) => selectedPrice.value = value,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: selectedDate,
              builder: (context, value, child) => ExpandedDatePicker(
                darkBlueBgColor: true,
                onDateChange: (value) => selectedDate.value = value,
                date: selectedDate.value,
              ),
            ),
            HotelsFilterButtons(onApplyFilters: applyFilters),
          ],
        ),
      ),
    );
  }
}
