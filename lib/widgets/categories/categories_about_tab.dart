import 'package:flutter/material.dart';
import 'package:soluxe/widgets/categories/categories_content_row.dart';

class CategoriesAboutTab extends StatelessWidget {
  const CategoriesAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        CategoriesContentRow(
          text: 'European, Uzbek',
          title: 'Kitchen',
          iconPath: 'assets/icons/grey-kitchen.svg',
        ),
        CategoriesContentRow(
          text: '2 400 000 Sum',
          title: 'Average price',
          iconPath: 'assets/icons/wallet.svg',
        ),
        CategoriesContentRow(
          text: 'Parturient lectus luctus magnis maximus lacus commodo',
          title: 'Address',
          iconPath: 'assets/icons/pin.svg',
        ),
        CategoriesContentRow.interactive(
          title: 'Contacts',
          phone: '+998 90 900 90 99',
          website: 'www.nihol.uz',
          iconPath: 'assets/icons/contacts-phone.svg',
        ),
        CategoriesContentRow(
          text: 'Daily 10:00 - 23:00',
          title: 'Opening hours',
          iconPath: 'assets/icons/bold-clock.svg',
        ),
      ],
    );
  }
}
