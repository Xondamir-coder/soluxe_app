import 'dart:convert';
import 'package:soluxe/models/formatted_date.dart';
import 'package:soluxe/models/place/base_place.dart';
import 'package:soluxe/models/place/place.dart';

class Event extends BasePlace {
  final String? titleEn;
  final String? titleZh;
  final String? eventDate;
  final String? eventDateTill;
  final int? placeId;
  final int? createdBy;
  final Place? place;
  final List<String>? mediaLinks;
  final String? address;
  final String? city;
  final String? latitude;
  final String? longitude;
  final String? region;

  Event({
    super.id,
    super.descriptionEn,
    super.descriptionZh,
    super.createdAt,
    super.updatedAt,
    this.titleEn,
    this.titleZh,
    this.eventDate,
    this.eventDateTill,
    this.placeId,
    this.createdBy,
    this.place,
    this.region,
    this.city,
    this.address,
    this.latitude,
    this.longitude,
    this.mediaLinks,
  });

  get lat => double.tryParse(latitude!);
  get lng => double.tryParse(latitude!);

  // If eventDate or eventDateTill is null, these getters return null.
  FormattedDate? get eventFormatted =>
      eventDate != null ? FormattedDate(DateTime.parse(eventDate!)) : null;
  FormattedDate? get eventTillFormatted => eventDateTill != null
      ? FormattedDate(DateTime.parse(eventDateTill!))
      : null;

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
      mediaLinks: map['media_links'] != null
          ? List<String>.from(map['media_links'])
          : null,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      placeId: map['place_id'] as int?,
      createdBy: map['created_by'] as int?,
      place: map['place'] != null ? Place.fromMap(map['place']) : null,
    );
  }

  @override
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
