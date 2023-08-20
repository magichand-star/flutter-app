import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray600 = fromHex('#797979');

  static Color deepOrange50 = fromHex('#f2e7db');

  static Color lime800 = fromHex('#9e7345');

  static Color brown80 = fromHex('#4e3114');

  static Color lime900 = fromHex('#794e23');

  static Color lightGreen100 = fromHex('#e3d2c4');

  static Color yellow50 = fromHex('#fff6ee');

  static Color orange200 = fromHex('#efcc9b');

  static Color orangeSolid = fromHex('#c9a87b');

  static Color bluegray900 = fromHex('#232640');

  static Color orange50 = fromHex('#fff4e9');

  static Color orange51 = fromHex('#fff3e8');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#888888');

  static Color yellow900 = fromHex('#c6731c');

  static Color whiteA700 = fromHex('#ffffff');

  static Color brown90 = fromHex('#3A2510');

  static Color brown70 = fromHex('#794f23');

  static Color brown60 = fromHex('#9E7346');

  static Color brown40 = fromHex('#C7731C');

  static Color brown10 = fromHex('#FFF6EE');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
