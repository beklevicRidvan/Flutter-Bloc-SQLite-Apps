import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants{


  static TextStyle getTitleTextStyle(int size){
    return TextStyle(
      color: Colors.white,
      fontSize: calculateFontSize(size),
      fontWeight: FontWeight.bold,

    );
  }
  static TextStyle getFontTextStyle(int size){
    return TextStyle(
      color: Colors.white,
      fontSize: calculateFontSize(size),
    );
  }
  static TextStyle getSubTitleTextStyle(int size){
    return TextStyle(
      color: Colors.grey,
      fontSize: calculateFontSize(size),
    );
  }
  static TextStyle getListItemTextStyle(){
    return TextStyle(
      color: Colors.white,
      fontSize: ScreenUtil().orientation == Orientation.portrait ? 19.w : 18.w
    );
  }

  static EdgeInsets getPadding (){
    if(ScreenUtil().orientation == Orientation.portrait){
      return EdgeInsets.all(10.h);
    }
    else{
      return EdgeInsets.all(25.w);
    }
  }

  static calculateFontSize(int size){
    if(ScreenUtil().orientation == Orientation.portrait){
      return size.sp;
    }
    else{
      return (size*1.2);
    }
  }
}