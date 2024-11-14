import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/food%20and%20Products/food_and_products_list.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/food/foods_controller.dart';
import 'package:collection_application/custom/button/completeButtons/custom_search_bar.dart';
import 'package:collection_application/templates/dialog/general_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodFinderDialog extends StatelessWidget {
  const FoodFinderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodsController());

    return GeneralDialog(
        child: SizedBox(
      height: Responsive.height(450),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'بحث',
            style: TextStyle(
                fontFamily: 'SF MADA', fontSize: Responsive.width(21)),
          ),
          Obx(() {
            return CustomSearchBar(
              textController: controller.textController,
              onPressed:
                  controller.isLoading.value ? () {} : controller.onSearch,
            );
          }),
          Expanded(
            child: FoodAndProductsList(
              onFoodTapped: (food, selectedUnit, quantity) {
                Get.back(result: [
                  food,
                  Ingrediant(
                      foodId: food.id, weight: selectedUnit.weight * quantity)
                ]);
              },
            ),
          )
        ],
      ),
    ));
  }

  static Future<List?> show() async {
    return Get.generalDialog<List?>(
      barrierColor: Colors.transparent,
      // barrierDismissible: true,
      // barrierLabel: '',
      transitionDuration: FoodFinderDialog.transitionDuration,
      transitionBuilder: FoodFinderDialog.transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const FoodFinderDialog(),
    );
  }

  void hide(Food? food) async {
    Get.closeAllSnackbars();
    Get.back<Food>(result: food);
    return;
  }

  static const transitionDuration = Duration(milliseconds: 300);
  static Widget transitionBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    final scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      ),
    );

    return FadeTransition(
      opacity: opacityAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }
}
