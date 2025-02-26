import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/content_row.dart';
import 'package:soluxe/widgets/event/event_date_item.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class EventScreen extends StatelessWidget {
  final Event event;

  const EventScreen({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const CircularBackButton(),
        actions: [
          Center(
            child: Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: AppColors.adaptiveDarkBlueOrWhite(isDark),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/dots-vertical.svg',
                  colorFilter: ColorFilter.mode(
                    AppColors.adaptiveLightWhiteOrRichBrown(isDark),
                    BlendMode.srcIn,
                  ),
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            SizedBox(
              width: double.infinity,
              height: 195,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: event.banner,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.deepBlue.withValues(alpha: .1)
                                : AppColors.creamWhite.withValues(alpha: .1),
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.deepBlue
                                : AppColors.creamWhite,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: event.images[0],
                      fit: BoxFit.cover,
                      height: 160,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      for (final image in event.images)
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: image,
                              fit: BoxFit.cover,
                              height: 60,
                            ),
                          ),
                        )
                    ],
                  ),
                  Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        event.title,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.adaptiveWhiteOrVeryDarkBrown(
                          isDark,
                        ),
                      ),
                      MyText(
                        event.description,
                        fontSize: 16,
                        color: AppColors.adaptiveAlmostWhiteOrWarmBrown(isDark),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      for (final date in event.dates) EventDateItem(date: date),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.deepBlue(event.weekday),
                          MyText.grey(event.timeSlot),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.accentYellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/date.svg',
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      ContentRow(
                        title: 'Average price',
                        text: event.averagePrice,
                        iconPath: 'assets/icons/wallet.svg',
                      ),
                      ContentRow.interactive(
                        title: 'Contacts',
                        phone: event.phoneNumber,
                        website: event.website,
                        iconPath: 'assets/icons/contacts-phone.svg',
                      ),
                      ContentRow(
                        title: 'Opening Hours',
                        text: event.openingHours,
                        iconPath: 'assets/icons/bold-clock.svg',
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.deepBlue('Location', fontSize: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: event.locationImgSrc,
                          fit: BoxFit.cover,
                          height: 160,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: YellowButton(
                          'Destination',
                          borderRadius: 12,
                          padding: 15,
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              width: 2,
                              color: AppColors.accentYellow,
                            ),
                            padding: EdgeInsets.all(15),
                          ),
                          child: MyText(
                            'Call',
                            color: AppColors.accentYellow,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
