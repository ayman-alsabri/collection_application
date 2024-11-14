import 'package:collection_application/app/views/home/bottomSheet/components/food/food_bottom_sheet.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/meals/meals_bottom_sheet.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/products/products_bottom_sheet.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThreeSwipersControllers controller = Get.find();
    return Obx(
      () {
        switch (controller.focusedIndex.value) {
          case Containers.meals:
            return const MealsBottomSheet();
          case Containers.products:
            return const ProductsBottomSheet();
          case Containers.foods:
            return const FoodBottomSheet();
        }
      },
    );
  }
}
