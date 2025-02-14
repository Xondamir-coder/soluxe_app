import 'package:flutter_svg/flutter_svg.dart';

class Language {
  final String name;
  final String code;
  final SvgPicture icon;

  const Language({
    required this.name,
    required this.code,
    required this.icon,
  });
}
