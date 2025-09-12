import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/widgets/drag_handle.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_date_picker.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_tags.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_buttons.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_rating.dart';
import 'package:soluxe/widgets/hotel/hotels_filter_type.dart';
import 'package:soluxe/widgets/price_range_slider.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class HotelsFilterSheet extends ConsumerStatefulWidget {
  final ValueChanged onApplyFilters;

  const HotelsFilterSheet({super.key, required this.onApplyFilters});

  @override
  ConsumerState<HotelsFilterSheet> createState() => _HotelsFilterSheetState();
}

class _HotelsFilterSheetState extends ConsumerState<HotelsFilterSheet> {
  // UI update managed in children separately
  var _selectedTagId = 0;
  var _selectedType = 'Hotel';
  var _selectedRating = 5;

  // UI update managed in parent
  var selectedDate =
      ValueNotifier<String>(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  var selectedPrice = ValueNotifier<RangeValues>(RangeValues(50, 400));

  @override
  void dispose() {
    selectedDate.dispose();
    selectedPrice.dispose();
    super.dispose();
  }

  void applyFilters() {
    final params = {
      'tag': _selectedTagId.toString(),
      'working_date': selectedDate.value,
      'sub_category': _selectedType,
      'rate': _selectedRating.toString(),
      'min_price': selectedPrice.value.start.toInt().toString(),
      'max_price': selectedPrice.value.end.toInt().toString(),
    };
    widget.onApplyFilters(params);
    Navigator.of(context).pop();
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
                  AppLocalizations.of(context)!.filter,
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
            HotelsFilterTags(
              onTagSelected: (value) => _selectedTagId = value,
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
              builder: (context, value, child) => HotelsFilterDatePicker(
                onDateChange: (value) => selectedDate.value = value,
                selectedDate: DateTime.parse(selectedDate.value),
              ),
            ),
            HotelsFilterButtons(onApplyFilters: applyFilters),
          ],
        ),
      ),
    );
  }
}
