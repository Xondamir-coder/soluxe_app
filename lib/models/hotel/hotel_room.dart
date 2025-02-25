import 'package:soluxe/models/hotel/hotel_amenity.dart';

class HotelRoom {
  final String title;
  final String star;
  final String price;
  final String imgSrc;
  final List<HotelAmenity> amenities;

  const HotelRoom({
    required this.title,
    required this.star,
    required this.price,
    required this.imgSrc,
    required this.amenities,
  });
}
