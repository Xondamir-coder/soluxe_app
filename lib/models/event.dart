import 'package:soluxe/models/places.dart';

class EventDate {
  final String month;
  final int day;
  const EventDate({required this.month, required this.day});
}

class Event extends Places {
  final String banner;
  final List<EventDate> dates;
  final String timeSlot;
  final String locationImgSrc;

  const Event({
    required this.dates,
    required this.banner,
    required this.timeSlot,
    required this.locationImgSrc,
    required super.averagePrice,
    required super.phoneNumber,
    required super.website,
    required super.openingHours,
    required super.description,
    required super.images,
    required super.star,
    required super.title,
    required super.location,
    required super.imgSrc,
    required super.dateString,
    required super.distance,
  });
}
