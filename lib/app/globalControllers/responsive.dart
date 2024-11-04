import 'package:flutter/material.dart';

class Responsive {
  static void init(BuildContext context) {
    _deviseHeight = MediaQuery.of(context).size.height;
    _deviseWidth = MediaQuery.of(context).size.width;
  }

  Responsive._privateConstructor();

  static late double _deviseHeight;
  static late double _deviseWidth;

  static double get deviseHeight => _deviseHeight;
  static double get deviseWidth => _deviseWidth;

  static Widget withHeightPercentage(double percentage, Widget child) {
    if (percentage > 1) throw Exception('cant have height greater than vh');
    return SizedBox(
      height: _deviseHeight * percentage,
      width: _deviseWidth,
      child: child,
    );
  }

  static double height(double absoluteHeight) {
    return absoluteHeight * (_deviseHeight / 844);
  }

  static double width(double absolutewidth) {
    return absolutewidth * (_deviseWidth / 419);
  }
}
