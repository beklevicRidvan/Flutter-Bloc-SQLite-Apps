import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants{
  static Color orangeColor = const Color(0xfff27b1d);



  static String calculateDate(DateTime date){
    return "${date.hour}:${date.minute}";
  }

  static double calculateFontSize(double size){
    return size.sw*1.1;
  }

  static TextStyle getFontTextStyle(double size){
    return TextStyle(
      fontSize: calculateFontSize(size),
    );
  }




}