import 'package:flutter/material.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.cancel,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          child: YellowButton(
            AppLocalizations.of(context)!.apply,
            onTap: onApplyFilters,
          ),
        ),
      ],
    );
  }
}
