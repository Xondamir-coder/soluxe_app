import 'package:intl/intl.dart';

class FormattedDate {
  final DateTime date;
  FormattedDate(this.date);

  String get day => date.day.toString();
  String get monthEn => DateFormat('MMM', 'en').format(date);
  String get timeEn => DateFormat('h:mm a', 'en').format(date);
  String get weekdayEn => DateFormat('EEEE', 'en').format(date);
  String get monthZh => DateFormat('MMM', 'zh').format(date);
  String get timeZh => DateFormat('h:mm a', 'zh').format(date);
  String get weekdayZh => DateFormat('EEEE', 'zh').format(date);
}
