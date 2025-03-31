import 'package:flutter/widgets.dart';
import 'package:soluxe/models/category.dart';

final categories = [
  Category(
    name: '酒店',
    apiName: 'Hotels',
    iconPath: 'assets/icons/building.svg',
    color: Color.fromRGBO(56, 189, 248, 1),
  ),
  Category(
    apiName: 'Restaurants',
    iconPath: 'assets/icons/kitchen.svg',
    color: Color.fromRGBO(136, 126, 249, 1),
  ),
  Category(
    apiName: 'Historical_place',
    iconPath: 'assets/icons/castle.svg',
    color: Color.fromRGBO(157, 120, 47, 1),
  ),
  Category(
    apiName: 'Museums',
    iconPath: 'assets/icons/house.svg',
    color: Color.fromRGBO(255, 128, 146, 1),
  ),
  Category(
    apiName: 'Entertainment',
    iconPath: 'assets/icons/joystick.svg',
    color: Color.fromRGBO(45, 212, 191, 1),
  ),
];
