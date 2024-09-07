import 'package:flutter/material.dart';

extension MediaQueryScreen on BuildContext {
  double get isHeightScreen => MediaQuery.sizeOf(this).height;
  double get isWidthScreen => MediaQuery.sizeOf(this).width;
}
