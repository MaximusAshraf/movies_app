import 'package:flutter/material.dart';
/// contain app basic styling
class AppStyle {
  AppStyle._();

  /// generate scale factor from screen size to scale text and ui
  static double scaleFactor(BuildContext context){
    double side = MediaQuery.of(context).size.shortestSide;
    return  side/(360) > 1.3 ? 1.3 : side/(360);
  }
}