import 'dart:convert';

class WorkingHour {
  final int? id;
  final int? placeId;
  final int? day;
  final String? openingTime;
  final String? closingTime;
  final String? createdAt;
  final String? updatedAt;
  WorkingHour({
    this.id,
    this.placeId,
    this.day,
    this.openingTime,
    this.closingTime,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'place_id': placeId,
      'day': day,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory WorkingHour.fromMap(Map<String, dynamic> map) {
    return WorkingHour(
      id: map['id'] as int?,
      placeId: map['place_id'] as int?,
      day: map['day'] as int?,
      openingTime: map['opening_time'] as String?,
      closingTime: map['closing_time'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingHour.fromJson(String source) =>
      WorkingHour.fromMap(json.decode(source) as Map<String, dynamic>);
}
