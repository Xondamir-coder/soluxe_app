import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class PriceRangeSlider extends StatelessWidget {
  final RangeValues selectedPrice;
  final ValueChanged<RangeValues> onSelectPrice;

  const PriceRangeSlider({
    super.key,
    required this.selectedPrice,
    required this.onSelectPrice,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      spacing: 4,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            // Track colors
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.veryLightPrimary,
            trackHeight: 4,

            // Hide tick marks if you don't want them
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
            rangeTrackShape: RectangularRangeSliderTrackShape(),

            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 12.0,
              elevation: 0,
            ),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
            thumbColor: Colors.white,
          ),
          child: RangeSlider(
            values: selectedPrice,
            min: 0,
            max: 2000,
            divisions: 40,
            labels: RangeLabels(
              '\$${selectedPrice.start.round()}',
              '\$${selectedPrice.end.round()}',
            ),
            onChanged: onSelectPrice,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              '\$0',
              color: AppColors.adaptiveDarkerGreyOrGrey(isDark),
            ),
            MyText(
              '\$2000',
              color: AppColors.adaptiveDarkerGreyOrGrey(isDark),
            ),
          ],
        )
      ],
    );
  }
}
