import 'dart:convert';

import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/models/user.dart';

class Review {
  final int? id;
  final int? userId;
  final int? placeId;
  final int? rating;
  final String? userAgent;
  final String? reviewText;
  final List<String>? mediaLinks;
  final String? createdAt;
  final String? updatedAt;
  final User? user;
  final Place? place;

  Review({
    this.id,
    this.userId,
    this.placeId,
    this.rating,
    this.userAgent,
    this.reviewText,
    this.mediaLinks,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.place,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'place_id': placeId,
      'rating': rating,
      'user_agent': userAgent,
      'review_text': reviewText,
      'media_links': mediaLinks,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toMap(),
      'place': place?.toMap(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as int?,
      userId: map['user_id'] as int?,
      placeId: map['place_id'] as int?,
      rating: map['rating'] as int?,
      userAgent: map['user_agent'] as String?,
      reviewText: map['review_text'] as String?,
      mediaLinks: map['media_links'] != null
          ? List<String>.from(map['media_links'])
          : null,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      place: map['place'] != null
          ? Place.fromMap(map['place'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
