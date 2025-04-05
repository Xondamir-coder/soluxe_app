import 'dart:convert';

class DateEntry {
  final int monthDay;
  final bool exists;
  DateEntry({
    required this.monthDay,
    required this.exists,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month_day': monthDay,
      'exists': exists,
    };
  }

  factory DateEntry.fromMap(Map<String, dynamic> map) {
    return DateEntry(
      monthDay: map['month_day'] as int,
      exists: map['exists'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DateEntry.fromJson(String source) =>
      DateEntry.fromMap(json.decode(source) as Map<String, dynamic>);
}
