import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/event/event.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/content_row.dart';
import 'package:soluxe/widgets/event/event_date_item.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            if (event.place?.images != null)
              SizedBox(
                width: double.infinity,
                height: 195,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            '${Constants.baseUrl}/${event.place?.images![0]}',
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
                  if (event.place?.images != null &&
                      event.place!.images!.length > 1)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            '${Constants.baseUrl}/${event.place?.images![1]}',
                        fit: BoxFit.cover,
                        height: 160,
                        width: double.infinity,
                      ),
                    ),
                  if (event.place?.images != null)
                    Row(
                      spacing: 6,
                      children: [
                        for (final image in event.place!.images!)
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: '${Constants.baseUrl}/$image',
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
                        event.titleEn ?? 'N/A',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.adaptiveWhiteOrVeryDarkBrown(
                          isDark,
                        ),
                      ),
                      MyText(
                        event.descriptionEn ?? 'N/A',
                        fontSize: 16,
                        color: AppColors.adaptiveAlmostWhiteOrWarmBrown(isDark),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      EventDateItem(
                        day: event.eventFormatted?.day ?? 'N/A',
                        month: event.eventFormatted?.month ?? 'N/A',
                      ),
                      EventDateItem(
                        day: event.eventTillFormatted?.day ?? 'N/A',
                        month: event.eventTillFormatted?.month ?? 'N/A',
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.deepBlue(
                              event.eventFormatted?.weekday ?? 'N/A'),
                          MyText.grey(
                            '${event.eventFormatted?.time ?? 'N/A'} - ${event.eventTillFormatted?.time ?? 'N/A'}',
                          ),
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
                        text: event.place?.priceRate.toString() ?? 'N/A',
                        iconPath: 'assets/icons/wallet.svg',
                      ),
                      if (event.place?.contactInfo != null &&
                          event.place?.contactUrl != null)
                        ContentRow.interactive(
                          title: 'Contacts',
                          phone: event.place!.contactInfo!,
                          website: event.place!.contactUrl!,
                          iconPath: 'assets/icons/contacts-phone.svg',
                        ),
                      ContentRow(
                        title: 'Opening Hours',
                        text: 'N/A',
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
                        child: Image.asset(
                          // placeholder: kTransparentImage,
                          'assets/images/map.png',
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
                          onPressed: () {
                            if (event.place?.contactInfo == null) return;
                            launchUrlString('tel:${event.place!.contactInfo}');
                          },
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
