class Pluralizer {
  String pluralizeRussianSurname(String surname) {
    RegExp malePattern = RegExp(r'(ов|ин|ын|ев|ёв|ов)$');
    RegExp femalePattern = RegExp(r'(ова|ина|ына|ева|ёва|ова)$');
    RegExp maleFemalePattern = RegExp(r'(ич|ыч)$');
    RegExp maleFemalePattern2 =
        RegExp(r'(кий|гий|хий|чий|ший|щий|кая|гая|хая|чая|шая|щая)$');
    RegExp maleFemalePattern3 = RegExp(
        r'(ный|вый|зый|бый|лый|рый|сый|тый|ная|вая|зая|бая|лая|рая|сая|тая)$');
    RegExp maleFemalePattern4 = RegExp(r'(ский|цкий|ской|цкой|ская|цкая)$');
    RegExp maleFemalePattern5 = RegExp(
        r'(той|вой|ной|зой|мой|пой|дой|бой|лой|рой|сой|фой|тая|вая|ная|зая|мая|пая|дая|бая|лая|рая|сая|фая)$');
    RegExp maleFemalePattern6 =
        RegExp(r'(кой|шой|гой|хой|щой|чой|кая|шая|гая|хая|щая|чая)$');

    bool hasHyphenOrSpace = surname.contains(RegExp(r'[-\s]'));

    if (hasHyphenOrSpace) {
      List<String> parts = surname.split(RegExp(r'[-\s]'));
      return parts.map((part) => pluralizeRussianSurname(part)).join('-');
    }

    if (malePattern.hasMatch(surname)) {
      return '$surnameы';
    } else if (femalePattern.hasMatch(surname)) {
      return '${surname.substring(0, surname.length - 1)}ы';
    } else if (maleFemalePattern.hasMatch(surname)) {
      return '$surnameи';
    } else if (maleFemalePattern2.hasMatch(surname) ||
        maleFemalePattern6.hasMatch(surname)) {
      return '${surname.substring(0, surname.length - 2)}ие';
    } else if (maleFemalePattern3.hasMatch(surname) ||
        maleFemalePattern5.hasMatch(surname)) {
      return '${surname.substring(0, surname.length - 2)}ые';
    } else if (maleFemalePattern4.hasMatch(surname)) {
      return '${surname.substring(0, surname.length - 2)}ские';
    } else {
      return surname;
    }
  }
}
