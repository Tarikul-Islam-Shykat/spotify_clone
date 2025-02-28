import 'package:flutter/material.dart';

class AppConstants {



  static double size2Text(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return height * 0.025;
  }

  static double size1Text(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return height * 0.015;
  }


}
