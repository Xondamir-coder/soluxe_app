import 'package:intl/intl.dart';

class HotelComment {
  final String imgSrc;
  final String name;
  final String dateString;
  final String text;

  const HotelComment({
    required this.imgSrc,
    required this.name,
    required this.dateString,
    required this.text,
  });

  DateTime get date => DateTime.parse(dateString);
  String get formattedDate => DateFormat('dd MMM yyyy').format(date);
}
