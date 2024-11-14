import 'package:collection_application/app/views/home/caloriesButtomSection/meals/meals_controller.dart';
import 'package:collection_application/custom/listTiles/custom_food_list_tile.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MealList extends StatelessWidget {
  const MealList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MealsController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Obx(() {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.meals.length,
                itemBuilder: (context, index) => CustomFoodListTile(
                      onDeleteFood: () async =>
                          controller.onDeleteFood(controller.meals[index]),
                      food: controller.meals[index],
                      canEdit: controller.meals[index].isMine,
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
