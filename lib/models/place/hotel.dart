// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/models/place/review.dart';

class Hotel {
  final Place? place;
  final Place? top;
  final Review? review;
  final int? reviewsCount;
  final double? reviewsAvgRating;
  final double? reviews5Stars;
  final double? reviews4Stars;
  final double? reviews3Stars;
  final double? reviews2Stars;
  final double? reviews1Stars;

  Hotel({
    this.place,
    this.top,
    this.review,
    this.reviewsCount,
    this.reviewsAvgRating,
    this.reviews5Stars,
    this.reviews4Stars,
    this.reviews3Stars,
    this.reviews2Stars,
    this.reviews1Stars,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'place': place?.toMap(),
      'top': top?.toMap(),
      'review': review?.toMap(),
      'reviews_count': reviewsCount,
      'reviews_avg_rating': reviewsAvgRating,
      'reviews_5stars': reviews5Stars,
      'reviews_4stars': reviews4Stars,
      'reviews_3stars': reviews3Stars,
      'reviews_2stars': reviews2Stars,
      'reviews_1stars': reviews1Stars,
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      place: map['place'] != null
          ? Place.fromMap(map['place'] as Map<String, dynamic>)
          : null,
      top: map['top'] != null
          ? Place.fromMap(map['top'] as Map<String, dynamic>)
          : null,
      review: map['review'] != null
          ? Review.fromMap(map['review'] as Map<String, dynamic>)
          : null,
      reviewsCount: map['reviews_count'] as int?,
      reviewsAvgRating: map['reviews_avg_rating'] != null
          ? double.tryParse(
              map['reviews_avg_rating'].toString(),
            )!
              .floorToDouble()
          : null,
      reviews5Stars: map['reviews_5stars'] != null
          ? double.tryParse(
              map['reviews_5stars'].toString(),
            )
          : null,
      reviews4Stars: map['reviews_4stars'] != null
          ? double.tryParse(
              map['reviews_4stars'].toString(),
            )
          : null,
      reviews3Stars: map['reviews_3stars'] != null
          ? double.tryParse(
              map['reviews_3stars'].toString(),
            )
          : null,
      reviews2Stars: map['reviews_2stars'] != null
          ? double.tryParse(
              map['reviews_2stars'].toString(),
            )
          : null,
      reviews1Stars: map['reviews_1stars'] != null
          ? double.tryParse(
              map['reviews_1stars'].toString(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hotel.fromJson(String source) =>
      Hotel.fromMap(json.decode(source) as Map<String, dynamic>);
}
