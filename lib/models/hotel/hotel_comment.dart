import 'package:intl/intl.dart';
import 'package:soluxe/models/user_summary.dart';

class HotelComment {
  final String text;
  final String dateString;
  final UserSummary user;

  const HotelComment({
    required this.user,
    required this.text,
    required this.dateString,
  });

  DateTime get date => DateTime.parse(dateString);
  String get formattedDate => DateFormat('dd MMM yyyy').format(date);
}
