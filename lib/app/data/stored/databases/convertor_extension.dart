import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/data/models/product.dart';

extension FoodListExtension on List<Map<String, dynamic>> {
  List<Food> toFoodList() {
    final newFoods = <Food>[];
    for (var food in this) {
      final units = [
        {'id': -1, 'name': '100 جرام', 'weight': 100},
        {'id': 0, 'name': 'جرام', 'weight': 1},
      ];

      final List? unitIds = (food['unitIds'])?.split('/');
      final List? unitNames = (food['unitNames'])?.split('/');
      final List? unitWeights = (food['unitWeights'])?.split('/');
      for (var i = 0; i < (unitIds ?? []).length; i++) {
        units.add({
          'id': int.parse(unitIds![i]),
          'name': unitNames![i],
          'weight': num.parse(unitWeights![i])
        });
      }
      newFoods.add(Food.fromJson(food, units));
    }
    return newFoods;
  }

  List<Product> toProductList() {
    final newProducts = <Product>[];
    for (var product in this) {
      final units = <Map<String, dynamic>>[];

      final List? unitIds = (product['unitIds'])?.split('/');
      final List? unitNames = (product['unitNames'])?.split('/');
      final List? unitWeights = (product['unitWeights'])?.split('/');
      for (var i = 0; i < (unitIds ?? []).length; i++) {
        units.add({
          'id': int.parse(unitIds![i]),
          'name': unitNames![i],
          'weight': double.parse(unitWeights![i])
        });
      }
      units.addAll([
        {'id': 0, 'name': 'جرام', 'weight': 1},
        {'id': -1, 'name': '100 جرام', 'weight': 100},
      ]);
      newProducts.add(Product.fromJson(product, units, product['barCode']));
    }
    return newProducts;
  }

  List<Meal> toMealList() {
    final newMeals = <Meal>[];
    for (var meal in this) {
      final units = [
        {'id': -1, 'name': '100 جرام', 'weight': 100},
        {'id': 0, 'name': 'جرام', 'weight': 1},
      ];
      final ingrediants = <Map<String, dynamic>>[];

      final List? unitIds = (meal['unitIds'])?.split('/');
      final List? unitNames = (meal['unitNames'])?.split('/');
      final List? unitWeights = (meal['unitWeights'])?.split('/');
      final List? ingrediantIds = (meal['ingrediantIds'])?.split('/');
      final List? ingrediantsWeights = (meal['ingrediantsWeights'])?.split('/');
      for (var i = 0; i < (unitIds ?? []).length; i++) {
        units.add({
          'id': int.parse(unitIds![i]),
          'name': unitNames![i],
          'weight': num.parse(unitWeights![i])
        });
      }
      for (var i = 0; i < (ingrediantIds ?? []).length; i++) {
        ingrediants.add({
          'foodId': int.parse(ingrediantIds![i]),
          'weight': num.parse(ingrediantsWeights![i])
        });
      }
      newMeals.add(Meal.fromJson(meal, ingrediants, units));
    }
    return newMeals;
  }
}
