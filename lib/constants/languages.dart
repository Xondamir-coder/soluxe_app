import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/models/language.dart';

class AppLanguages {
  static Language english = Language(
    code: 'en',
    nameEn: 'English',
    nameZh: '英语',
    icon: SvgPicture.asset('assets/icons/flag-en.svg'),
  );
  static Language chinese = Language(
    code: 'zh',
    nameEn: 'Chinese',
    nameZh: '中文',
    icon: SvgPicture.asset('assets/icons/flag-zh.svg'),
  );
  static List<Language> languages = [
    english,
    chinese,
  ];
}
