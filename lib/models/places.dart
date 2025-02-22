// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class Places {
  final String title;
  final String location;
  final String imgSrc;
  final String dateString;
  final String distance;
  final String star;

  const Places({
    required this.title,
    required this.location,
    required this.imgSrc,
    required this.dateString,
    required this.distance,
    required this.star,
  });

  DateTime get date => DateTime.parse(dateString);
  String get day => date.day.toString();
  String get month => DateFormat('MMM').format(date);
  String get time => DateFormat('h:mm a').format(date);

  Places copyWith({
    String? title,
    String? location,
    String? imgSrc,
    String? dateString,
    String? distance,
    String? star,
  }) {
    return Places(
      title: title ?? this.title,
      location: location ?? this.location,
      imgSrc: imgSrc ?? this.imgSrc,
      dateString: dateString ?? this.dateString,
      distance: distance ?? this.distance,
      star: star ?? this.star,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'location': location,
      'imgSrc': imgSrc,
      'dateString': dateString,
      'distance': distance,
      'star': star,
    };
  }

  factory Places.fromMap(Map<String, dynamic> map) {
    return Places(
      title: map['title'] as String,
      location: map['location'] as String,
      imgSrc: map['imgSrc'] as String,
      dateString: map['dateString'] as String,
      distance: map['distance'] as String,
      star: map['star'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Places.fromJson(String source) =>
      Places.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Places(title: $title, location: $location, imgSrc: $imgSrc, dateString: $dateString, distance: $distance, star: $star)';
  }

  @override
  bool operator ==(covariant Places other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.location == location &&
        other.imgSrc == imgSrc &&
        other.dateString == dateString &&
        other.distance == distance &&
        other.star == star;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        location.hashCode ^
        imgSrc.hashCode ^
        dateString.hashCode ^
        distance.hashCode ^
        star.hashCode;
  }
}
