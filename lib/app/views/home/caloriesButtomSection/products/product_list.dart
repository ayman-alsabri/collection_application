import 'package:collection_application/app/views/home/caloriesButtomSection/products/products_controller.dart';
import 'package:collection_application/custom/listTiles/custom_food_list_tile.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Obx(() {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (context, index) => CustomFoodListTile(
                      onDeleteFood: () async =>
                          controller.onDeleteFood(controller.products[index]),
                      food: controller.products[index],
                      canEdit: controller.products[index].isMine,
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
