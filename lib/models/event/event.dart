import 'dart:convert';
import 'package:intl/intl.dart';
import 'place.dart';

class FormattedDate {
  final DateTime date;
  FormattedDate(this.date);

  String get day => date.day.toString();
  String get month => DateFormat('MMM').format(date);
  String get time => DateFormat('h:mm a').format(date);
  String get weekday => DateFormat('EEEE').format(date);
}

class Event {
  final int? id;
  final String? titleEn;
  final String? titleZh;
  final String? descriptionEn;
  final String? descriptionZh;
  final String? eventDate;
  final String? eventDateTill;
  final String? createdAt;
  final String? updatedAt;
  final int? placeId;
  final int? createdBy;
  final Place? place;
  final String? mediaLinks;
  final String? address;
  final String? city;
  final String? latitude;
  final String? longitude;
  final String? region;

  Event({
    this.id,
    this.titleEn,
    this.titleZh,
    this.descriptionEn,
    this.descriptionZh,
    this.eventDate,
    this.eventDateTill,
    this.placeId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.place,
    this.region,
    this.city,
    this.address,
    this.latitude,
    this.longitude,
    this.mediaLinks,
  });

  // If eventDate or eventDateTill is null, these getters return null.
  FormattedDate? get eventFormatted =>
      eventDate != null ? FormattedDate(DateTime.parse(eventDate!)) : null;
  FormattedDate? get eventTillFormatted => eventDateTill != null
      ? FormattedDate(DateTime.parse(eventDateTill!))
      : null;

  Event copyWith({
    int? id,
    String? titleEn,
    String? titleZh,
    String? descriptionEn,
    String? descriptionZh,
    String? eventDate,
    String? eventDateTill,
    String? address,
    String? region,
    String? city,
    String? latitude,
    String? longitude,
    String? mediaLinks,
    int? placeId,
    int? createdBy,
    String? createdAt,
    String? updatedAt,
    Place? place,
  }) {
    return Event(
      id: id ?? this.id,
      titleEn: titleEn ?? this.titleEn,
      titleZh: titleZh ?? this.titleZh,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      eventDate: eventDate ?? this.eventDate,
      eventDateTill: eventDateTill ?? this.eventDateTill,
      placeId: placeId ?? this.placeId,
      region: region ?? this.region,
      city: city ?? this.city,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      mediaLinks: mediaLinks ?? this.mediaLinks,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      place: place ?? this.place,
    );
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as int?,
      titleEn: map['title_en'] as String?,
      titleZh: map['title_zh'] as String?,
      descriptionEn: map['description_en'] as String?,
      descriptionZh: map['description_zh'] as String?,
      eventDate: map['event_date'] as String?,
      eventDateTill: map['event_date_till'] as String?,
      address: map['address'] as String?,
      region: map['region'] as String?,
      city: map['city'] as String?,
      latitude: map['latitude'] as String?,
      longitude: map['longitude'] as String?,
      mediaLinks: map['media_links'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      placeId: map['place_id'] as int?,
      createdBy: map['created_by'] as int?,
      place: map['place'] != null ? Place.fromMap(map['place']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titleEn': titleEn,
      'titleZh': titleZh,
      'descriptionEn': descriptionEn,
      'descriptionZh': descriptionZh,
      'eventDate': eventDate,
      'eventDateTill': eventDateTill,
      'placeId': placeId,
      'address': address,
      'region': region,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'mediaLinks': mediaLinks,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'place': place,
    };
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);
}
