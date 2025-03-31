import 'package:flutter_svg/flutter_svg.dart';

class Language {
  final String nameEn;
  final String nameZh;
  final String code;
  final SvgPicture icon;

  const Language({
    required this.nameEn,
    required this.nameZh,
    required this.code,
    required this.icon,
  });
}
