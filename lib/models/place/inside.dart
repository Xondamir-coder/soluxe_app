import 'package:soluxe/models/place/base_place.dart';
import 'package:soluxe/models/place/tag.dart';

class Inside extends BasePlace {
  final int? placeId;
  final String? image;

  Inside({
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
    this.placeId,
    this.image,
  });

  factory Inside.fromMap(Map<String, dynamic> map) {
    return Inside(
      id: map['id'] as int?,
      placeId: map['place_id'] as int?,
      nameEn: map['name_en'] as String?,
      nameZh: map['name_zh'] as String?,
      descriptionEn: map['description_en'] as String?,
      descriptionZh: map['description_zh'] as String?,
      priceRate: map['price_rate'] as int?,
      image: map['image'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      reviewsCount: map['reviews_count'] as int?,
      reviewsAvgRating: map['reviews_avg_rating'] != null
          ? double.tryParse(map['reviews_avg_rating'])
          : null,
      tags: map['tags'] != null
          ? List<Tag>.from((map['tags'] as List)
              .map((x) => Tag.fromMap(x as Map<String, dynamic>)))
          : null,
    );
  }
}
