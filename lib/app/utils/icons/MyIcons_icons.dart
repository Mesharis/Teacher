// Place fonts/MyIcons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: MyIcons
//      fonts:
//       - asset: fonts/MyIcons.ttf
// ignore_for_file: constant_identifier_names, file_names

import 'package:flutter/widgets.dart';

class MyIcons {
  MyIcons._();

  static const String _fontFamily = 'MyIcons';

  static const IconData calendar_add = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData calendar_tick = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData edit = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData home_2 = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData message = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData profile = IconData(0xe905, fontFamily: _fontFamily);
  static const IconData undo = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData user_square = IconData(0xe907, fontFamily: _fontFamily);
  static const IconData wallet_3 = IconData(0xe908, fontFamily: _fontFamily);
}
