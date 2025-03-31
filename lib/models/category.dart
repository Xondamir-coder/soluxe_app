import 'package:flutter/material.dart';

class Category {
  final String? name;
  final String apiName;
  final String iconPath;
  final Color color;

  const Category({
    this.name,
    required this.iconPath,
    required this.color,
    required this.apiName,
  });
}
