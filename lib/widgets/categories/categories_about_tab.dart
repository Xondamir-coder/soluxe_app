import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/providers/currency_provider.dart';
import 'package:soluxe/widgets/content_row.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class CategoriesAboutTab extends ConsumerWidget {
  final Place place;

  const CategoriesAboutTab({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(currencyProvider);
    final List<String> openingHours = [];

    for (var i = 0; i < place.workingHours!.length; i++) {
      final workingHour = place.workingHours![i];
      final weekdays = AppLocalizations.of(context)!.localeName == 'zh'
          ? Constants.weekdaysZh
          : Constants.weekdaysEn;
      final weekday = weekdays[i];
      final text =
          '$weekday: ${workingHour.openingTime!.substring(0, 5)} - ${workingHour.closingTime!.substring(0, 5)}';
      openingHours.add(text);
    }

    final price = place.priceRate == null
        ? 'Unknown'
        : '\$ ${(place.priceRate! / currency).floorToDouble()}';
    return Column(
      spacing: 16,
      children: [
        ContentRow(
          text:
              '${AppLocalizations.of(context)!.european}, ${AppLocalizations.of(context)!.uzbek}',
          title: AppLocalizations.of(context)!.kitchen,
          iconPath: 'assets/icons/grey-kitchen.svg',
        ),
        ContentRow(
          text: price,
          title: AppLocalizations.of(context)!.averagePrice,
          iconPath: 'assets/icons/wallet.svg',
        ),
        ContentRow(
          text: place.address,
          title: AppLocalizations.of(context)!.address,
          iconPath: 'assets/icons/pin.svg',
        ),
        ContentRow.interactive(
          title: AppLocalizations.of(context)!.contacts,
          phone: place.contactInfo ?? '',
          website: place.contactUrl ?? '',
          iconPath: 'assets/icons/contacts-phone.svg',
        ),
        ContentRow(
          texts: openingHours,
          title: AppLocalizations.of(context)!.openingHours,
          iconPath: 'assets/icons/bold-clock.svg',
        ),
      ],
    );
  }
}
