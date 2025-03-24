import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/position_helper.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/widgets/buttons/grey_outlined_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/categories/categories_about_tab.dart';
import 'package:soluxe/widgets/categories/categories_photo_tab.dart';
import 'package:soluxe/widgets/star_rating.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum Tabs {
  about,
  photo,
}

String capitalize(String text) =>
    '${text[0].toUpperCase()}${text.substring(1)}';

class CategoriesContent extends StatefulWidget {
  final Place place;

  const CategoriesContent({super.key, required this.place});

  @override
  State<CategoriesContent> createState() => _CategoriesContentState();
}

class _CategoriesContentState extends State<CategoriesContent> {
  var _selectedTab = Tabs.about;

  Widget _buildDot(bool isDark) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.adaptiveDarkGreyOrGrey(isDark),
      ),
    );
  }

  Widget _buildTop(bool isDark) {
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
                MyText.deepBlue(widget.place.nameEn!, fontSize: 20),
                SvgPicture.asset('assets/icons/blue-check.svg'),
              ],
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: SvgPicture.asset(
                  isDark ? 'assets/icons/dark-x.svg' : 'assets/icons/x.svg'),
            ),
          ],
        ),
        // top bottom details part
        Row(
          spacing: 10,
          children: [
            StarRating(star: widget.place.reviewsAvgRating ?? 0),
            _buildDot(isDark),
            SvgPicture.asset('assets/icons/car.svg'),
            FutureBuilder(
              future: determinePosition(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return MyText.grey('Loading ...', fontSize: 12);
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final position = snapshot.data!;
                  final distanceInKm = Geolocator.distanceBetween(
                        position.latitude,
                        position.longitude,
                        widget.place.lat,
                        widget.place.lng,
                      ) /
                      1000;
                  const averageSpeedKmPerHour = 60.0;
                  final estimatedTimeInHours =
                      distanceInKm / averageSpeedKmPerHour;
                  final estimatedTimeInMinutes = estimatedTimeInHours * 60;

                  String displayTime;
                  if (estimatedTimeInMinutes >= 60) {
                    displayTime =
                        '${estimatedTimeInHours.toStringAsFixed(1)} hour(s)';
                  } else {
                    displayTime =
                        '${estimatedTimeInMinutes.toStringAsFixed(0)} minutes';
                  }
                  return MyText.grey(
                    displayTime,
                    fontSize: 12,
                  );
                }
                return MyText.grey('N/A', fontSize: 12);
              },
            ),
            _buildDot(isDark),
            FutureBuilder(
              future: determinePosition(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return MyText.grey('Loading ...', fontSize: 12);
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final position = snapshot.data!;
                  final text = (Geolocator.distanceBetween(
                            position.latitude,
                            position.longitude,
                            widget.place.lat,
                            widget.place.lng,
                          ) /
                          1000)
                      .floor();

                  return MyText.grey('$text km', fontSize: 12);
                }
                return MyText.grey('N/A', fontSize: 12);
              },
            ),
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
                              : isDark
                                  ? AppColors.darkBlue
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
                if (widget.place.longitude != null &&
                    widget.place.latitude != null) {
                  launchUrlString(
                      "https://yandex.com/maps/?pt=${widget.place.longitude},${widget.place.latitude}&z=12&l=map");
                }
              },
            ),
          ),
          Expanded(
            child: GreyOutlinedButton(
              'Call',
              onTap: () {
                if (widget.place.contactInfo == null) return;
                launchUrlString('tel:${widget.place.contactInfo}');
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
          color: AppColors.adaptiveDeepBlueOrWhite(isDark),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        child: Column(
          spacing: 16,
          children: [
            _buildTop(isDark),
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
                  : CategoriesPhotoTab(
                      key: ValueKey('photo tab'),
                      images: widget.place.images!,
                    ),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
