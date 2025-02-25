import 'package:intl/intl.dart';

class Places {
  final String title;
  final String description;
  final String location;
  final String imgSrc;
  final String dateString;
  final String distance;
  final String star;
  final List<String> images;
  final String averagePrice;
  final String phoneNumber;
  final String website;
  final String openingHours;

  const Places({
    required this.averagePrice,
    required this.phoneNumber,
    required this.website,
    required this.openingHours,
    required this.description,
    required this.images,
    required this.title,
    required this.location,
    required this.imgSrc,
    required this.dateString,
    required this.distance,
    required this.star,
  });

  DateTime get date => DateTime.parse(dateString);
  String get day => date.day.toString();
  String get month => DateFormat('MMM').format(date);
  String get time => DateFormat('h:mm a').format(date);
  String get weekday => DateFormat('EEEE').format(date);
}
