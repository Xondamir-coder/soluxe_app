import 'package:intl/intl.dart';

class Event {
  final String title;
  final String city;
  final String imgSrc;
  final String dateString;
  final String distance;

  const Event(
      {required this.title,
      required this.city,
      required this.dateString,
      required this.imgSrc,
      required this.distance});

  DateTime get date => DateTime.parse(dateString);
  String get day => date.day.toString();
  String get month => DateFormat('MMM').format(date);
  String get time => DateFormat('h:mm a').format(date);
}
