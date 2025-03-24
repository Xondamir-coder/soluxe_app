import 'dart:convert';

import 'package:soluxe/models/event.dart';
import 'package:soluxe/models/place/base_place.dart';
import 'package:soluxe/models/place/inside.dart';
import 'package:soluxe/models/place/working_hour.dart';
import 'package:soluxe/models/place/tag.dart';

class Place extends BasePlace {
  final String? category;
  final String? subCategory;
  final String? hotelCategory;
  final String? address;
  final String? region;
  final String? city;
  final String? latitude;
  final String? longitude;
  final String? contactInfo;
  final List<String>? images;
  final String? contactUrl;
  final int? createdBy;
  final List<Inside>? inside;
  final List<WorkingHour>? workingHours;
  final List<Event>? events;

  get lat => double.tryParse(latitude!);
  get lng => double.tryParse(latitude!);

  Place({
    super.id,
    super.nameEn,
    super.nameZh,
    super.descriptionEn,
    super.descriptionZh,
    super.priceRate,
    super.createdAt,
    super.updatedAt,
    super.reviewsCount,
    super.reviewsAvgRating,
    super.tags,
    this.category,
    this.subCategory,
    this.hotelCategory,
    this.address,
    this.region,
    this.city,
    this.latitude,
    this.longitude,
    this.contactInfo,
    this.images,
    this.contactUrl,
    this.createdBy,
    this.inside,
    this.workingHours,
    this.events,
  });

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as int?,
      nameEn: map['name_en'] as String?,
      nameZh: map['name_zh'] as String?,
      category: map['category'] as String?,
      subCategory: map['sub_category'] as String?,
      hotelCategory: map['hotel_category'] as String?,
      descriptionEn: map['description_en'] as String?,
      descriptionZh: map['description_zh'] as String?,
      priceRate: map['price_rate'] as int?,
      address: map['address'] as String?,
      region: map['region'] as String?,
      city: map['city'] as String?,
      latitude: map['latitude'] as String?,
      longitude: map['longitude'] as String?,
      contactInfo: map['contact_info'] as String?,
      images: map['images'] != null
          ? List<String>.from(json.decode(map['images']))
          : null,
      contactUrl: map['contact_url'] as String?,
      createdBy: map['created_by'] as int?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      reviewsCount: map['reviews_count'] as int?,
      reviewsAvgRating: map['reviews_avg_rating'] != null
          ? double.tryParse(map['reviews_avg_rating'].toString())
          : null,
      tags: map['tags'] != null
          ? List<Tag>.from((map['tags'] as List)
              .map((x) => Tag.fromMap(x as Map<String, dynamic>)))
          : null,
      inside: map['inside'] != null
          ? List<Inside>.from((map['inside'] as List)
              .map((x) => Inside.fromMap(x as Map<String, dynamic>)))
          : null,
      workingHours: map['working_hours'] != null
          ? List<WorkingHour>.from((map['working_hours'] as List)
              .map((x) => WorkingHour.fromMap(x as Map<String, dynamic>)))
          : null,
      events: map['events'] != null
          ? List<Event>.from((map['events'] as List)
              .map((x) => Event.fromMap(x as Map<String, dynamic>)))
          : null,
    );
  }
}
