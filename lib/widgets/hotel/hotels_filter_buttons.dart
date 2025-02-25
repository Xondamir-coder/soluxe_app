import 'package:flutter/material.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';

class HotelsFilterButtons extends StatelessWidget {
  final void Function() onApplyFilters;

  const HotelsFilterButtons({super.key, required this.onApplyFilters});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: GreyOutlinedButton(
            'Cancel',
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(child: YellowButton('Apply', onTap: onApplyFilters)),
      ],
    );
  }
}
