import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/providers/currency_provider.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/content_row.dart';
import 'package:soluxe/widgets/event/event_date_item.dart';
import 'package:soluxe/widgets/location_map.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventScreen extends ConsumerWidget {
  final Event event;

  const EventScreen({required this.event, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<String> openingHours = [];
    final localeName = AppLocalizations.of(context)!.localeName;

    for (var i = 0; i < event.place!.workingHours!.length; i++) {
      final workingHour = event.place!.workingHours![i];
      final weekdays =
          localeName == 'zh' ? Constants.weekdaysZh : Constants.weekdaysEn;
      final weekday = weekdays[i];

      final text =
          '$weekday: ${workingHour.openingTime!.substring(0, 5)} - ${workingHour.closingTime!.substring(0, 5)}';
      openingHours.add(text);
    }

    final currency = ref.read(currencyProvider);
    final price = event.place?.priceRate == null
        ? 'Unknown'
        : '\$ ${(event.place!.priceRate! / currency).floorToDouble()}';

    final eventTime = localeName == 'zh'
        ? event.eventFormatted?.timeZh
        : event.eventFormatted?.timeEn;
    final eventTillTime = localeName == 'zh'
        ? event.eventTillFormatted?.timeZh
        : event.eventTillFormatted?.timeEn;
    final eventMonth = localeName == 'zh'
        ? event.eventFormatted?.monthZh
        : event.eventFormatted?.monthEn;
    final eventTillMonth = localeName == 'zh'
        ? event.eventTillFormatted?.monthZh
        : event.eventTillFormatted?.monthEn;
    final weekday = localeName == 'zh'
        ? event.eventFormatted?.weekdayZh
        : event.eventFormatted?.weekdayEn;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const CircularBackButton(),
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
                            '${Constants.baseUrl}/${event.place?.images!.first}',
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
                        (localeName == 'en' ? event.titleEn : event.titleZh) ??
                            'N/A',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.adaptiveWhiteOrDarkPrimary(
                          isDark,
                        ),
                      ),
                      MyText(
                        (localeName == 'en'
                                ? event.descriptionEn
                                : event.descriptionZh) ??
                            'N/A',
                        fontSize: 16,
                        color:
                            AppColors.adaptiveAlmostWhiteOrWarmPrimary(isDark),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      EventDateItem(
                        day: event.eventFormatted?.day ?? 'N/A',
                        month: eventMonth ?? 'N/A',
                      ),
                      EventDateItem(
                        day: event.eventTillFormatted?.day ?? 'N/A',
                        month: eventTillMonth ?? 'N/A',
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.deepBlue(weekday ?? 'N/A'),
                          MyText.grey(
                            '${eventTime ?? 'N/A'} - ${eventTillTime ?? 'N/A'}',
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
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
                        title: AppLocalizations.of(context)!.averagePrice,
                        text: price,
                        iconPath: 'assets/icons/wallet.svg',
                      ),
                      if (event.place?.contactInfo != null &&
                          event.place?.contactUrl != null)
                        ContentRow.interactive(
                          title: AppLocalizations.of(context)!.contacts,
                          phone: event.place!.contactInfo!,
                          website: event.place!.contactUrl!,
                          iconPath: 'assets/icons/contacts-phone.svg',
                        ),
                      ContentRow(
                        title: AppLocalizations.of(context)!.openingHours,
                        texts: openingHours,
                        iconPath: 'assets/icons/bold-clock.svg',
                      ),
                    ],
                  ),
                  if (event.latitude != null && event.longitude != null)
                    Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.deepBlue('Location', fontSize: 16),
                        Container(
                          height: 160,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: LocationMap(
                            latitude: event.lat,
                            longitude: event.lng,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: YellowButton(
                          AppLocalizations.of(context)!.destination,
                          borderRadius: 12,
                          padding: 15,
                          onTap: () {
                            if (event.longitude != null &&
                                event.latitude != null) {
                              launchUrlString(
                                  "https://yandex.com/maps/?pt=${event.longitude},${event.latitude}&z=12&l=map");
                            }
                          },
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
                              color: AppColors.primary,
                            ),
                            padding: EdgeInsets.all(15),
                          ),
                          child: MyText(
                            AppLocalizations.of(context)!.call,
                            color: AppColors.primary,
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
