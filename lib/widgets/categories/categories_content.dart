import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/categories/categories_content_row.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

enum Tabs {
  about,
  photo,
}

String capitalize(String text) =>
    '${text[0].toUpperCase()}${text.substring(1)}';

class CategoriesContent extends StatefulWidget {
  const CategoriesContent({super.key});

  @override
  State<CategoriesContent> createState() => _CategoriesContentState();
}

class _CategoriesContentState extends State<CategoriesContent> {
  var _selectedTab = Tabs.about;

  Widget _buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.grey,
      ),
    );
  }

  Widget _buildTop() {
    return Column(
      spacing: 9,
      children: [
        // naming part
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4,
              children: [
                MyText.deepBlue('Besh Qozon', fontSize: 20),
                SvgPicture.asset('assets/icons/blue-check.svg'),
              ],
            ),
            SvgPicture.asset('assets/icons/x.svg'),
          ],
        ),
        // top bottom details part
        Row(
          spacing: 10,
          children: [
            // stars part
            Row(
              spacing: 6,
              children: [
                // stars
                Row(
                  children: [
                    for (var i = 0; i < 5; i++)
                      SvgPicture.asset(
                        'assets/icons/star.svg',
                        colorFilter: ColorFilter.mode(
                          Color.fromRGBO(255, 199, 0, 1),
                          BlendMode.srcIn,
                        ),
                      ),
                  ],
                ),
                MyText.grey('3', fontSize: 12),
              ],
            ),
            _buildDot(),
            SvgPicture.asset('assets/icons/car.svg'),
            MyText.grey('5 min', fontSize: 12),
            _buildDot(),
            MyText.grey('1 Km', fontSize: 12),
          ],
        ),
        Row(
          children: [
            for (final tab in Tabs.values)
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedTab = tab),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13.5),
                    child: Column(
                      spacing: 13.5,
                      children: [
                        MyText(
                          capitalize(tab.name),
                          fontWeight: FontWeight.w700,
                          color: _selectedTab == tab
                              ? AppColors.accentYellow
                              : AppColors.grey,
                        ),
                        Container(
                          height: _selectedTab == tab ? 3 : 1,
                          color: _selectedTab == tab
                              ? AppColors.accentYellow
                              : Color.fromRGBO(229, 231, 235, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: YellowButton(
              'Destination',
              onTap: () {},
            ),
          ),
          Expanded(
            child: GreyOutlinedButton(
              'Call',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: Column(
        spacing: 16,
        children: [
          _buildTop(),
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
          _buildActionButtons(),
        ],
      ),
    );
  }
}
