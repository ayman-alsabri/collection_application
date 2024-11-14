import 'package:collection_application/app/data/models/food.dart';

const _foodId = 'foodId';
const _weight = 'weight';

final class Meal extends Food {
  List<Ingrediant> ingrediants;
  Meal(
      {required super.id,
      required super.name,
      required super.caloriePer100g,
      required super.protine,
      required super.carbs,
      required super.fat,
      super.isMine = true,
      super.units = const [],
      super.category,
      required this.ingrediants});

  Meal.fromJson(super.meal, List<Map<String, dynamic>> ingrediants,
      [super.units = const []])
      : ingrediants = ingrediants
            .map(
              (e) => Ingrediant.fromJson(e),
            )
            .toList(),
        super.fromJson();

  Meal.fromFood(super.food, List<Ingrediant> newIngrediants)
      : ingrediants = newIngrediants,
        super.fromFood();
}

class Ingrediant {
  final int foodId;
  double weight;

  Ingrediant({
    required this.foodId,
    required this.weight,
  });
  Ingrediant.fromJson(Map<String, dynamic> ingrediant)
      : foodId = ingrediant[_foodId],
        weight = (ingrediant[_weight]as num).toDouble();

  bool existsBetween(List<Ingrediant> ingrediants) {
    for (var ing in ingrediants) {
      if (ing.foodId == foodId) return true;
    }
    return false;
  }
}
