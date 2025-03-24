import 'dart:convert';

import 'package:soluxe/models/place/pivot.dart';

class Tag {
  final int id;
  final String category;
  final String icon;
  final String nameEn;
  final String nameZh;
  final String createdAt;
  final String updatedAt;
  final Pivot pivot;

  Tag({
    required this.id,
    required this.category,
    required this.icon,
    required this.nameEn,
    required this.nameZh,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'icon': icon,
      'name_en': nameEn,
      'name_zh': nameZh,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot.toMap(),
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as int,
      category: map['category'] as String,
      icon: map['icon'] as String,
      nameEn: map['name_en'] as String,
      nameZh: map['name_zh'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      pivot: Pivot.fromMap(map['pivot'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) =>
      Tag.fromMap(json.decode(source) as Map<String, dynamic>);
}
