import 'package:soluxe/models/places.dart';

class Hotel extends Places {
  const Hotel({
    required super.star,
    required super.title,
    required super.location,
    required super.imgSrc,
    required super.dateString,
    required super.distance,
  });
}
