import 'package:flutter/cupertino.dart';

class SizeConfig {
  static double screenWidthFigma = 375;
  static double screenHeightFigma = 812;
  static double screenWidth = 0;
  static double screenHeight = 0;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    //لو العرض اصغر من الطول فى الوضع الطبيعى نحط العرض عادى غير كدا حط الطول
    screenWidth = size.width < size.height ? size.width : size.height;
    screenHeight = size.height > size.width ? size.height : size.width;
  }

  static dynamic widthRatio(double width) {
    return (width / screenWidthFigma) * screenWidth;
  }

  static dynamic heightRatio(double height) {
    return (height / screenHeightFigma) * screenHeight;
  }
}
