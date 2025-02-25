import 'package:soluxe/models/hotel/hotel_amenity.dart';
import 'package:soluxe/models/hotel/hotel_comment.dart';
import 'package:soluxe/models/hotel/hotel_review.dart';
import 'package:soluxe/models/hotel/hotel_room.dart';
import 'package:soluxe/models/places.dart';

class Hotel extends Places {
  final String price;
  final String description;
  final HotelReview review;
  final List<String> images;
  final List<HotelAmenity> amenities;
  final List<HotelRoom> rooms;
  final List<HotelComment> comments;
  final List<HotelRoom> similars;
  final List<String> facilitiesIconPaths;

  const Hotel({
    required this.similars,
    required this.facilitiesIconPaths,
    required this.review,
    required this.comments,
    required this.images,
    required this.amenities,
    required this.description,
    required this.price,
    required this.rooms,
    required super.star,
    required super.title,
    required super.location,
    required super.imgSrc,
    required super.dateString,
    required super.distance,
  });
}
