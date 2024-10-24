import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Responsive {

Responsive._privateConstructor();
static final instanse = Responsive._privateConstructor();

  final _deviseHeight = Get.mediaQuery.size.height;
  final _deviseWidth = Get.mediaQuery.size.width;

  get deviseHeight => _deviseHeight;
  get deviseWidth => _deviseWidth;


  Widget withHeightPercentage(double percentage,Widget child){
    if(percentage > 1)throw Exception('cant have height greater than vh');
    return SizedBox(height: _deviseHeight * percentage ,width: _deviseWidth,child:child ,);
  }
  double height(double absoluteHeight){
    return  absoluteHeight  * (_deviseHeight/844);
  }
  double width(double absolutewidth){
    return absolutewidth * (_deviseWidth /419);
  }
}