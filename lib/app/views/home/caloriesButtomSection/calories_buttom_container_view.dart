import 'package:collection_application/app/views/home/caloriesButtomSection/food/food_list.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/food/foods_controller.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/meals/meal_list.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/meals/meals_controller.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/products/product_list.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/products/products_controller.dart';
import 'package:collection_application/custom/button/completeButtons/custom_search_bar.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_controllers.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaloriesButtomContainer extends StatelessWidget {
  const CaloriesButtomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThreeSwipersControllers>();

    return Obx(() {
      return Column(
        children: [
          CustomSearchBar(textController: () {
            final foodsController = Get.put(FoodsController());
            final productsController = Get.put(ProductsController());
            final mealscontroller = Get.put(MealsController());
            switch (controller.focusedIndex.value) {
              case Containers.meals:
                foodsController.dispose();
                productsController.dispose();
                return mealscontroller.textController;
              case Containers.products:
                foodsController.dispose();
                mealscontroller.dispose();
                return productsController.textController;
              case Containers.foods:
                productsController.dispose();
                mealscontroller.dispose();
                return foodsController.textController;
            }
          }(), onPressed: () {
            switch (controller.focusedIndex.value) {
              case Containers.meals:
                Get.find<MealsController>().onSearch();
                break;
              case Containers.products:
                Get.find<ProductsController>().onSearch();
                break;
              case Containers.foods:
                Get.find<FoodsController>().onSearch();
                break;
            }
          }),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: shadowColor),
              BoxShadow(
                  color: bottomGradientStartColor,
                  offset: Offset(0, 6),
                  blurRadius: 4,
                  spreadRadius: 2),
            ]),
            child: () {
              switch (controller.focusedIndex.value) {
                case Containers.meals:
                  return const MealList();
                case Containers.products:
                  return const ProductList();
                case Containers.foods:
                  return const FoodList();
              }
            }(),
          )),
        ],
      );
    });
  }
}
