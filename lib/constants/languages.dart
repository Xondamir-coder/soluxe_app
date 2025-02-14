import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/models/language.dart';

class AppLanguages {
  static Language english = Language(
    code: 'en',
    name: 'English',
    icon: SvgPicture.asset('assets/icons/flag-en.svg'),
  );
  static Language chinese = Language(
    code: 'zh',
    name: 'Chinese',
    icon: SvgPicture.asset('assets/icons/flag-zh.svg'),
  );
  static List<Language> languages = [
    english,
    chinese,
  ];
}
