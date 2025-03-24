import 'package:intl/intl.dart';

class FormattedDate {
  final DateTime date;
  FormattedDate(this.date);

  String get day => date.day.toString();
  String get month => DateFormat('MMM').format(date);
  String get time => DateFormat('h:mm a').format(date);
  String get weekday => DateFormat('EEEE').format(date);
}
