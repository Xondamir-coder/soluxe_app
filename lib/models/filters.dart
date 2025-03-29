// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:soluxe/models/place/tag.dart';

class Filters {
  final List<String> subCategories;
  final List<String> cities;
  final List<Tag> tags;

  const Filters({
    required this.subCategories,
    required this.cities,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_categories': subCategories,
      'cities': cities,
      'tags': tags.isNotEmpty ? tags.map((x) => x.toMap()).toList() : [],
    };
  }

  factory Filters.fromMap(Map<String, dynamic> map) {
    return Filters(
      subCategories: List<String>.from(map['sub_categories']),
      cities: List<String>.from(map['cities']),
      tags: (map['tags'] as List).isNotEmpty
          ? List<Tag>.from((map['tags'] as List)
              .map<Tag?>((x) => Tag.fromMap(x as Map<String, dynamic>)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Filters.fromJson(String source) =>
      Filters.fromMap(json.decode(source) as Map<String, dynamic>);
}
