import 'package:soluxe/models/place/tag.dart';

abstract class BasePlace {
  final int? id;
  final String? nameEn;
  final String? nameZh;
  final String? descriptionEn;
  final String? descriptionZh;
  final int? priceRate;
  final String? createdAt;
  final String? updatedAt;
  final int? reviewsCount;
  final double? reviewsAvgRating;
  final List<Tag>? tags;

  BasePlace({
    this.id,
    this.nameEn,
    this.nameZh,
    this.descriptionEn,
    this.descriptionZh,
    this.priceRate,
    this.createdAt,
    this.updatedAt,
    this.reviewsCount,
    this.reviewsAvgRating,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_zh': nameZh,
      'description_en': descriptionEn,
      'description_zh': descriptionZh,
      'price_rate': priceRate,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'reviews_count': reviewsCount,
      'reviews_avg_rating': reviewsAvgRating,
      'tags': tags?.map((x) => x.toMap()).toList(),
    };
  }

  List<Tag> get uniqueTags {
    final Map<String, Tag> uniqueMap = {};

    for (var tag in tags!) {
      uniqueMap[tag.category!] = tag;
    }

    return uniqueMap.values.toList();
  }
}
