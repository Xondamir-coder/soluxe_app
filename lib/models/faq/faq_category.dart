import 'dart:convert';

class FaqCategory {
  final int? id;
  final String? icon;
  final String? color;
  final String? titleEn;
  final String? titleZh;
  final String? createdAt;
  final String? updatedAt;

  FaqCategory({
    this.id,
    this.icon,
    this.color,
    this.titleEn,
    this.titleZh,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'icon': icon,
      'color': color,
      'title_en': titleEn,
      'title_zh': titleZh,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory FaqCategory.fromMap(Map<String, dynamic> map) {
    return FaqCategory(
      id: map['id'] as int?,
      icon: map['icon'] as String?,
      color: map['color'] as String?,
      titleEn: map['title_en'] as String?,
      titleZh: map['title_zh'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory FaqCategory.fromJson(String source) =>
      FaqCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
