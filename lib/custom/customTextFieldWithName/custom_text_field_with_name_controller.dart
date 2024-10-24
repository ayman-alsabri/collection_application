import 'package:get/get.dart';

class CustomTextFieldWithNameController extends GetxController {
  final RxBool hideText = true.obs;

  void toggleTextAppearance() {
    hideText.value = !hideText.value;
  }
}
