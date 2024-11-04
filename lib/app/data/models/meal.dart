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

class Meal {
  final int id;
  final String name;
  final String? category;
  final bool isMine;
  int caloriePer100g;
  int protine;
  int carbs;
  int fat;
  List<Ingrediant> ingrediants;
  Meal(
      {required this.id,
      required this.name,
      required this.caloriePer100g,
      required this.protine,
      required this.carbs,
      required this.fat,
      this.isMine = true,
      this.category,
      required this.ingrediants});

  Meal.fromJson(
      Map<String, dynamic> meal, List<Map<String, dynamic>> ingrediants)
      : id = meal[_mealId],
        name = meal[_name],
        caloriePer100g = meal[_caloriesPer100g],
        isMine = meal[_isMine],
        protine = meal[_protinePer100g],
        fat = meal[_fatPer100g],
        carbs = meal[_carbPer100g],
        category = meal[_foodCategory],
        ingrediants = ingrediants
            .map(
              (e) => Ingrediant.fromJson(e),
            )
            .toList();
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
