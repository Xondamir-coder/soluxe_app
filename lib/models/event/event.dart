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
  final int id;
  final String titleEn;
  final String titleZh;
  final String descriptionEn;
  final String descriptionZh;
  final String eventDate;
  final String eventDateTill;
  final String address;
  final String region;
  final String city;
  final String latitude;
  final String longitude;
  final String mediaLinks;
  final String createdAt;
  final String updatedAt;
  final int placeId;
  final int createdBy;
  final Place place;
  Event({
    required this.id,
    required this.titleEn,
    required this.titleZh,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.eventDate,
    required this.eventDateTill,
    required this.placeId,
    required this.region,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.mediaLinks,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.place,
  });

  // Getters
  FormattedDate get eventFormatted => FormattedDate(DateTime.parse(eventDate));
  FormattedDate get eventTillFormatted =>
      FormattedDate(DateTime.parse(eventDateTill));

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
      id: map['id'].toInt(),
      titleEn: map['title_en'] as String,
      titleZh: map['title_zh'] as String,
      descriptionEn: map['description_en'] as String,
      descriptionZh: map['description_zh'] as String,
      eventDate: map['event_date'] as String,
      eventDateTill: map['event_date_till'] as String,
      address: map['address'] as String,
      region: map['region'] as String,
      city: map['city'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      mediaLinks: map['media_links'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      placeId: map['place_id'].toInt(),
      createdBy: map['created_by'].toInt(),
      place: Place.fromMap(map['place']),
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
