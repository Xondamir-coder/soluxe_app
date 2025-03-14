import 'package:intl/intl.dart';
import 'package:soluxe/models/user.dart';

class HotelComment {
  final String text;
  final String dateString;
  final User user;

  const HotelComment({
    required this.user,
    required this.text,
    required this.dateString,
  });

  DateTime get date => DateTime.parse(dateString);
  String get formattedDate => DateFormat('dd MMM yyyy').format(date);
}
