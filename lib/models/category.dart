import 'package:flutter/material.dart';

class Category {
  final String name;
  final String iconPath;
  final Color color;
  final List<String> categories;

  const Category({
    required this.name,
    required this.iconPath,
    required this.color,
    this.categories = const [],
  });
}
