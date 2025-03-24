import 'dart:convert';

class Pivot {
  final int? placeId;
  final int? tagId;

  Pivot({
    this.placeId,
    this.tagId,
  });

  Map<String, dynamic> toMap() {
    return {
      'place_id': placeId,
      'tag_id': tagId,
    };
  }

  factory Pivot.fromMap(Map<String, dynamic> map) {
    return Pivot(
      placeId: map['place_id'] as int?,
      tagId: map['tag_id'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pivot.fromJson(String source) =>
      Pivot.fromMap(json.decode(source) as Map<String, dynamic>);
}
