import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConstant {
  static Color orange50 = fromHex('#fce6cf');

  static Color black900 = fromHex('#000000');

  static Color orange700 = fromHex('#f07d0a');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
