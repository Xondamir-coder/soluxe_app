import 'package:flutter/widgets.dart';
import 'package:soluxe/models/category.dart';

final categories = [
  Category(
    name: 'Hotels',
    iconPath: 'assets/icons/building.svg',
    color: Color.fromRGBO(56, 189, 248, 1),
  ),
  Category(
    name: 'Restaurants',
    iconPath: 'assets/icons/kitchen.svg',
    color: Color.fromRGBO(136, 126, 249, 1),
    subCategories: ['All', 'Banquet hall', 'Bar', 'Fast Food', 'Cafe'],
  ),
  Category(
    name: 'Historical Places',
    iconPath: 'assets/icons/castle.svg',
    color: Color.fromRGBO(157, 120, 47, 1),
  ),
  Category(
    name: 'Museums',
    iconPath: 'assets/icons/house.svg',
    color: Color.fromRGBO(255, 128, 146, 1),
  ),
  Category(
    name: 'Entertainment Places',
    iconPath: 'assets/icons/joystick.svg',
    color: Color.fromRGBO(45, 212, 191, 1),
  ),
  Category(
    name: 'Events',
    iconPath: 'assets/icons/date.svg',
    color: Color.fromRGBO(59, 130, 246, 1),
  ),
];
