import 'dart:math';

import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/helpers/r_rect_stroke_clipper.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class CaloriesNutritionChart extends StatelessWidget {
  final Food food;
  final Unit usedUnit;
  final int quantity;
  const CaloriesNutritionChart({
    super.key,
    required this.food,
    required this.usedUnit,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final size = Responsive.width(97);
    final carbsColor = Color.alphaBlend(
      Colors.white.withOpacity(0.9),
      Colors.black,
    );
    final protineColor = Color.alphaBlend(
      Colors.white.withOpacity(0.5),
      bluegradientStartColor,
    );
    final fatsColor = Color.alphaBlend(
      Colors.white.withOpacity(0.5),
      bluegradientEndColor,
    );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: caloriesNutritionChartGradiant,
                begin: Alignment(-0.5, -1),
                end: Alignment(0.5, 1),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 3,
                  right: 5,
                  child: CircularProgressChart(
                    usedUnit: usedUnit,
                    food: food,
                    quantity: quantity,
                    size: size * 0.711,
                    carbsColor: carbsColor,
                    fatsColor: fatsColor,
                    protineColor: protineColor,
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: 7,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'دهن',
                            style: TextStyle(
                                height: 1,
                                fontFamily: 'SF MADA',
                                fontSize: size / 8,
                                color: fatsColor),
                          ),
                          Text(
                            'كارب',
                            style: TextStyle(
                                height: 1,
                                fontFamily: 'SF MADA',
                                fontSize: size / 8,
                                color: carbsColor),
                          ),
                          Text(
                            'بروتين',
                            style: TextStyle(
                                height: 1,
                                fontFamily: 'SF MADA',
                                fontSize: size / 8,
                                color: protineColor),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          ClipPath(
            clipper: RRectStrokeClipper(
              borderRadius: 20,
              strokeWidth: 4,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    strokeGradientStartColor.withOpacity(0.2),
                    strokeGradientEndColor.withOpacity(0.2)
                  ],
                  begin: const Alignment(-0.7, -1.3),
                  end: const Alignment(0.6, -0.3),
                ),
              ),
              child: const SizedBox.expand(),
            ),
          )
        ],
      ),
    );
  }
}

class CircularProgressChart extends StatelessWidget {
  final Food food;
  final Unit usedUnit;
  final int quantity;
  final double size;
  final Color carbsColor;
  final Color protineColor;
  final Color fatsColor;

  const CircularProgressChart({
    super.key,
    required this.food,
    required this.usedUnit,
    required this.quantity,
    required this.size,
    required this.carbsColor,
    required this.fatsColor,
    required this.protineColor,
  });

  double calculateCalories() {
    final double caloriesPerUnit = (food.caloriePer100g * usedUnit.weight);
    final double totalCalories =
        (caloriesPerUnit * quantity).roundToDouble() / 100;
    return totalCalories;
  }

  @override
  Widget build(BuildContext context) {
    final totalNutrintion = food.carbs + food.protine + food.fat;
    final double calories = calculateCalories();
    final double carbsPercent = food.carbs / totalNutrintion;
    final double proteinPercent = food.protine / totalNutrintion;
    final double fatPercent = food.fat / totalNutrintion;

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            strokeAlign: BorderSide.strokeAlignInside,
            value: 1.0,
            strokeWidth: size / 7.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.alphaBlend(
                Colors.black38,
                caloriesNutritionChartGradiant.first,
              ),
            ),
          ),
          CircularProgressIndicator(
            strokeAlign: BorderSide.strokeAlignInside,
            value: fatPercent - 0.005,
            strokeWidth: size / 7.5,
            valueColor: AlwaysStoppedAnimation<Color>(fatsColor),
          ),
          Transform.rotate(
            angle: fatPercent * 2 * pi,
            child: CircularProgressIndicator(
              strokeAlign: BorderSide.strokeAlignInside,
              value: carbsPercent - 0.005,
              strokeWidth: size / 7.5,
              valueColor: AlwaysStoppedAnimation<Color>(carbsColor),
            ),
          ),
          Transform.rotate(
            angle: (carbsPercent + fatPercent) * 2 * pi,
            child: CircularProgressIndicator(
              strokeAlign: BorderSide.strokeAlignInside,
              value: proteinPercent - 0.005,
              strokeWidth: size / 7.5,
              valueColor: AlwaysStoppedAnimation<Color>(protineColor),
            ),
          ),
          FittedBox(
            child: Container(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: Text(
                      '$calories',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: 'TITR'),
                    ),
                  ),
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'سعرة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: 8, fontFamily: 'TITR'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
