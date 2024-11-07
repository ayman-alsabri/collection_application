import 'package:collection_application/app/data/models/unit.dart';

const _foodId = 'id';
const _name = 'foodName';
const _caloriesPer100g = 'caloriesPer100g';
const _protinePer100g = 'protine';
const _carbPer100g = 'carb';
const _fatPer100g = 'fat';
const _foodCategory = 'category';
const _isMine = 'isMine';

base class Food {
  final int id;
  final String name;
  final String? category;
  final bool isMine;
  int caloriePer100g;
  double protine;
  double carbs;
  double fat;
  List<Unit> units;

  Food({
    required this.id,
    required this.name,
    required this.caloriePer100g,
    required this.protine,
    required this.carbs,
    required this.fat,
    required this.units,
    this.isMine = true,
    this.category,
  });

  Food.fromJson(Map<String, dynamic> food, List<Map<String, dynamic>> units)
      : id = food[_foodId],
        name = food[_name],
        caloriePer100g = food[_caloriesPer100g],
        isMine = food[_isMine],
        protine = food[_protinePer100g],
        fat = food[_fatPer100g],
        carbs = food[_carbPer100g],
        category = food[_foodCategory],
        units = units
            .map(
              (e) => Unit.fromJson(e),
            )
            .toList();

  Food.fromFood(Food food)
      : id = food.id,
        name = food.name,
        caloriePer100g = food.caloriePer100g,
        isMine = food.isMine,
        protine = food.protine,
        fat = food.fat,
        carbs = food.carbs,
        category = food.category,
        units = food.units;
}
