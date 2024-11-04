import 'package:get/get.dart';

class SwiperController extends GetxController{
 final showShadow = true.obs;
 static const duration = Duration(milliseconds: 200);

 Future<void> onTap()async{
  showShadow.value = false;
  await Future.delayed(duration);
  showShadow.value = true;

 }



}