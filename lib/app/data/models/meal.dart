import 'package:collection_application/app/data/models/food.dart';

const _mealId = 'id';
const _name = 'foodName';
const _caloriesPer100g = 'caloriesPer100g';
const _protinePer100g = 'protine';
const _carbPer100g = 'carb';
const _fatPer100g = 'fat';
const _foodCategory = 'category';
const _isMine = 'isMine';

const _foodId = 'foodId';
const _unitId = 'unitId';
const _quantity = 'quantity';

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
}

class Ingrediant {
  final int foodId;
  int unitId;
  double quantity;

  Ingrediant({
    required this.foodId,
    required this.unitId,
    required this.quantity,
  });
  Ingrediant.fromJson(Map<String, dynamic> ingrediant)
      : foodId = ingrediant[_foodId],
        unitId = ingrediant[_unitId],
        quantity = ingrediant[_quantity];
}
