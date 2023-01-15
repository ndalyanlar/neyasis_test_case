import 'package:flutter/material.dart';

class MyLocalization {
  static final List<Locale> localList = [
    tr,
    en,
  ];
  static const Locale tr = Locale("tr", "TR");
  static const Locale en = Locale("en", "US");

  static String path = "assets/i18n";
}
