import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/position_helper.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/screens/event.dart';
import 'package:soluxe/widgets/tile/my_tile_bottom.dart';
import 'package:soluxe/widgets/tile/my_tile_image.dart';
import 'package:soluxe/widgets/tile/my_tile_title.dart';

class MyTileEvent extends StatelessWidget {
  final Event event;

  const MyTileEvent({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double spacing = 16;
    Color titleColor = AppColors.deepBlue;
    double titleFontSize = 14;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.adaptiveDarkBlueOrWhite(isDark),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => EventScreen(event: event),
            ),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            spacing: 10,
            children: [
              MyTileImage(
                imgSrc: '${Constants.baseUrl}/${event.place?.images?.first}',
                day: event.eventFormatted?.day ?? 'Unknown',
                month: event.eventFormatted?.month ?? 'Unknown',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spacing,
                  children: [
                    MyTileTitle(
                      title: event.titleEn ?? 'Unknown',
                      color: isDark ? Colors.white : titleColor,
                      fontSize: titleFontSize,
                    ),
                    FutureBuilder<Position>(
                        future: determinePosition(),
                        builder: (context, snapshot) {
                          if (event.latitude == null ||
                              event.longitude == null) {
                            return MyTileBottom(
                              location: event.city ?? 'Unknown',
                              distance: 'N/A',
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return MyTileBottom(
                              location: event.city ?? 'Unknown',
                              distance: 'Loading ...',
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            {
                              final position = snapshot.data!;

                              final distance = (Geolocator.distanceBetween(
                                        position.latitude,
                                        position.longitude,
                                        event.lat,
                                        event.lng,
                                      ) /
                                      1000)
                                  .floor();
                              return MyTileBottom(
                                location: event.city ?? 'Unknown',
                                distance: '$distance',
                              );
                            }
                          } else {
                            return MyTileBottom(
                              location: event.city ?? 'Unknown',
                              distance: 'N/A',
                            );
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
