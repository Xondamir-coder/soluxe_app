import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/screens/event.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int? animDelay;

  const EventCard({super.key, required this.event, this.animDelay});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SlideInWidget.fade(
      begin: const Offset(0, 0.25),
      delay: animDelay ?? 0,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => EventScreen(event: event),
          ),
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.only(right: 16),
          width: 250,
          child: Stack(
            children: [
              Positioned.fill(
                child: FadeInImage.memoryNetwork(
                  image: event.imgSrc,
                  placeholder: kTransparentImage,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.adaptiveDeepBlueOrWhite(isDark),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              event.day,
                              style: GoogleFonts.instrumentSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.adaptiveAccentWhiteOrDeepBlue(
                                    isDark),
                              ),
                            ),
                            Text(
                              event.month,
                              style: GoogleFonts.instrumentSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.adaptiveDeepBlueOrWhite(isDark),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        spacing: 8,
                        children: [
                          MyText(
                            event.title,
                            color: AppColors.adaptiveAccentWhiteOrDarkBrown(
                                isDark),
                            fontWeight: FontWeight.w700,
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              MyText(
                                event.location,
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              MyText(
                                event.time,
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
