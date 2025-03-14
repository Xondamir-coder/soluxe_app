import 'dart:convert';

import 'package:soluxe/constants/constants.dart';

class Place {
  final int id;
  final String nameEn;
  final String nameZh;
  final String category;
  final String subCategory;
  final String hotelCategory;
  final String descriptionEn;
  final String descriptionZh;
  final int priceRate;
  final String address;
  final String region;
  final String city;
  final String latitude;
  final String longitude;
  final String contactInfo;
  final String contactUrl;
  final List<String> images;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  Place({
    required this.id,
    required this.nameEn,
    required this.nameZh,
    required this.category,
    required this.subCategory,
    required this.hotelCategory,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.priceRate,
    required this.address,
    required this.region,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.contactInfo,
    required this.images,
    required this.contactUrl,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  Place copyWith({
    int? id,
    String? nameEn,
    String? nameZh,
    String? category,
    String? subCategory,
    String? hotelCategory,
    String? descriptionEn,
    String? descriptionZh,
    int? priceRate,
    String? address,
    String? region,
    String? city,
    String? latitude,
    String? longitude,
    String? contactInfo,
    List<String>? images,
    String? contactUrl,
    int? createdBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return Place(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameZh: nameZh ?? this.nameZh,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      hotelCategory: hotelCategory ?? this.hotelCategory,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      priceRate: priceRate ?? this.priceRate,
      address: address ?? this.address,
      region: region ?? this.region,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      contactInfo: contactInfo ?? this.contactInfo,
      images: images ?? this.images,
      contactUrl: contactUrl ?? this.contactUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name_en': nameEn,
      'name_zh': nameZh,
      'category': category,
      'sub_category': subCategory,
      'hotel_category': hotelCategory,
      'description_en': descriptionEn,
      'description_zh': descriptionZh,
      'price_rate': priceRate,
      'address': address,
      'region': region,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'contact_info': contactInfo,
      'images': json.encode(images),
      'contact_url': contactUrl,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    final imagesArr = json.decode(map['images']) as List<String>;
    final images = imagesArr.map((e) => '${Constants.imgUrl}/$e').toList();

    return Place(
      id: map['id'].toInt() as int,
      nameEn: map['name_en'] as String,
      nameZh: map['name_zh'] as String,
      category: map['category'] as String,
      subCategory: map['sub_category'] as String,
      hotelCategory: map['hotel_category'] as String,
      descriptionEn: map['description_en'] as String,
      descriptionZh: map['description_zh'] as String,
      priceRate: map['price_rate'].toInt() as int,
      address: map['address'] as String,
      region: map['region'] as String,
      city: map['city'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      contactInfo: map['contact_info'] as String,
      images: images,
      contactUrl: map['contact_url'] as String,
      createdBy: map['created_by'].toInt() as int,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);
}
