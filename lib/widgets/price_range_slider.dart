import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';

class PriceRangeSlider extends StatelessWidget {
  final RangeValues selectedPrice;
  final Function(RangeValues) onSelectPrice;

  const PriceRangeSlider({
    super.key,
    required this.selectedPrice,
    required this.onSelectPrice,
  });

  @override
  Widget build(BuildContext context) {
    print('building slider');
    return Column(
      children: [
        // Range Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.accentYellow,
            inactiveTrackColor: Color.fromRGBO(243, 234, 216, 1),
            trackHeight: 4,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
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

        // Price Labels
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: const [
        //       Text("\$0", style: TextStyle(color: Colors.grey)),
        //       Text("\$50", style: TextStyle(fontWeight: FontWeight.bold)),
        //       Text("\$400", style: TextStyle(fontWeight: FontWeight.bold)),
        //       Text("\$2000", style: TextStyle(color: Colors.grey)),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
