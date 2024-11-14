import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/food/foods_controller.dart';
import 'package:collection_application/custom/listTiles/custom_food_list_tile.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FoodList extends StatelessWidget {
  final void Function(Food food, Unit selectedUnit, int quantity)? onFoodTapped;

  const FoodList({
    this.onFoodTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodsController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Obx(() {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.foods.length,
                itemBuilder: (context, index) => CustomFoodListTile(
                      onDeleteFood: () async =>
                          controller.onDeleteFood(controller.foods[index]),
                      onTap: onFoodTapped,
                      food: controller.foods[index],
                      canEdit: controller.foods[index].isMine,
                    ));
          }),
          Obx(
            () => controller.isFull.value
                ? const SizedBox()
                : controller.isLoading.value
                    ? LoadingAnimationWidget.horizontalRotatingDots(
                        color: bluegradientEndColor, size: 18 * 2)
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: controller.onLoadMore,
                            child: const Text(
                              'تحميل المزيد',
                              style: TextStyle(
                                  fontFamily: 'SF MADA',
                                  color: bluegradientEndColor,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
