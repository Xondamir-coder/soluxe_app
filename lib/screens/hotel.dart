import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/hotel/hotel.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/hotel/hotel_amenities.dart';
import 'package:soluxe/widgets/hotel/hotel_comments.dart';
import 'package:soluxe/widgets/hotel/hotel_header.dart';
import 'package:soluxe/widgets/hotel/hotel_images.dart';
import 'package:soluxe/widgets/hotel/hotel_reviews.dart';
import 'package:soluxe/widgets/hotel/hotel_rooms.dart';
import 'package:soluxe/widgets/hotel/hotel_rooms_item.dart';
import 'package:soluxe/widgets/section_header.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class HotelScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelScreen({required this.hotel, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const DefaultAppbar(backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotelImages(images: hotel.images),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  HotelHeader(
                    iconPaths: hotel.facilitiesIconPaths,
                    star: hotel.star,
                    location: hotel.location,
                    price: hotel.price,
                    title: hotel.title,
                  ),
                  MyText(
                    hotel.description,
                    fontSize: 12,
                    color: AppColors.adaptiveGreyOrDarkerGrey(isDark),
                  ),
                  HotelAmenities(amenities: hotel.amenities),
                  HotelRooms(rooms: hotel.rooms),
                  Column(
                    spacing: 10,
                    children: [
                      SectionHeader(
                        title: 'User Reviews',
                        onTap: () => print('opening user reviews'),
                      ),
                      SizedBox(
                        height: 141,
                        child: Row(
                          spacing: 16,
                          children: [
                            Flexible(
                              flex: 3,
                              child: HotelReviews(review: hotel.review),
                            ),
                            Flexible(
                              flex: 6,
                              child: HotelComments(comments: hotel.comments),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      SectionHeader(
                        title: 'Top picks hotel',
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: hotel.rooms.length,
                          separatorBuilder: (ctx, index) =>
                              const SizedBox(width: 10),
                          itemBuilder: (ctx, index) {
                            return Builder(
                              builder: (context) {
                                final screenWidth =
                                    MediaQuery.of(context).size.width;
                                return SizedBox(
                                  width: screenWidth * 0.85,
                                  child:
                                      HotelRoomsItem(room: hotel.rooms[index]),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
