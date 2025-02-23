import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/categories/categories_about_tab.dart';
import 'package:soluxe/widgets/categories/categories_photo_tab.dart';
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
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: SvgPicture.asset('assets/icons/x.svg'),
            ),
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
                          i < 3
                              ? Color.fromRGBO(255, 199, 0, 1)
                              : AppColors.grey,
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
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: YellowButton(
              'Destination',
              onTap: () {
                print('goign to Destination');
              },
            ),
          ),
          Expanded(
            child: GreyOutlinedButton(
              'Call',
              onTap: () {
                print('goign to Destination');
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -20),
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 0,
        ),
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
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Using a FadeTransition; you can also use SlideTransition, ScaleTransition, etc.
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _selectedTab == Tabs.about
                  ? CategoriesAboutTab(key: ValueKey('about tab'))
                  : CategoriesPhotoTab(key: ValueKey('photo tab')),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
