import 'dart:convert';

import 'package:soluxe/models/faq/faq_category.dart';

class FaqQuestion {
  final int? id;
  final int? faqsCategoriesId;
  final String? titleEn;
  final String? titleZh;
  final String? bodyEn;
  final String? bodyZh;
  final String? createdAt;
  final String? updatedAt;
  final FaqCategory? category;

  FaqQuestion({
    this.id,
    this.faqsCategoriesId,
    this.titleEn,
    this.titleZh,
    this.bodyEn,
    this.bodyZh,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'faqs_categories_id': faqsCategoriesId,
      'title_en': titleEn,
      'title_zh': titleZh,
      'body_en': bodyEn,
      'body_zh': bodyZh,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'category': category?.toMap(),
    };
  }

  factory FaqQuestion.fromMap(Map<String, dynamic> map) {
    return FaqQuestion(
      id: map['id'] as int?,
      faqsCategoriesId: map['faqs_categories_id'] as int?,
      titleEn: map['title_en'] as String?,
      titleZh: map['title_zh'] as String?,
      bodyEn: map['body_en'] as String?,
      bodyZh: map['body_zh'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      category: map['category'] == null
          ? null
          : FaqCategory.fromMap(map['category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FaqQuestion.fromJson(String source) =>
      FaqQuestion.fromMap(json.decode(source) as Map<String, dynamic>);
}
