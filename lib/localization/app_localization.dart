import 'package:get/get.dart';

import 'ru_ru/ru_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ru_RU': ru,
        'en_US': ru,
        'en_UK': ru,
      };
}
