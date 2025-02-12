import 'package:soluxe/models/language.dart';

class AppLanguages {
  static const Language english = Language(
    code: 'en',
    name: 'English',
  );
  static const Language chinese = Language(
    code: 'zh',
    name: 'Chinese',
  );
  static const List<Language> languages = [
    english,
    chinese,
  ];
}
