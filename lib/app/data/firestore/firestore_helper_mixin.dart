import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/data/stored/userData/user_data_helper.dart';

const _name = 'foodName';
const _caloriesPer100g = 'caloriesPer100g';
const _protinePer100g = 'protine';
const _carbPer100g = 'carb';
const _fatPer100g = 'fat';
const _foodType = 'type';
const _foodCategory = 'category';

mixin FirestoreHelperMixin {
  final _functions = FirebaseFunctions.instance;
  final _userDataHelper = UserDataHelper();

  Future<void> addFood(
      {required Food food,
      required List<Unit> units,
      required List<Ingrediant> ingrediants,
      required String? barcode}) async {
    final type = ingrediants.isEmpty
        ? barcode == null
            ? 'طعام'
            : 'منتج'
        : 'وجبة';
    final foodtype = ingrediants.isEmpty
        ? barcode == null
            ? 'food'
            : 'product'
        : 'meal';
    final email = await _userDataHelper.getEmail();
    final points = await _userDataHelper.getPoints();

    final response = await _functions.httpsCallable('addFood').call({
      'title': 'تم اضافة $type جديد${ingrediants.isNotEmpty ? 'ة' : ''}',
      'body': food.name,
      'foodData': {
        'senderData': {
          'email': email!,
          'points': points,
        },
        "food": {
          'id': food.id,
          _name: food.name,
          _caloriesPer100g: food.caloriePer100g,
          _carbPer100g: food.carbs,
          _protinePer100g: food.protine,
          _fatPer100g: food.fat,
          _foodType: foodtype,
          _foodCategory: food.category,
        },
        ..._setUnitsAsString(units),
        ..._setIngrediantsAsString(ingrediants),
        'barcode': barcode,
      },
    });
    if (!response.data['success']) throw Error();
  }

  Future<void> deleteFood(Food food) async {
    final email = await _userDataHelper.getEmail();
    final points = await _userDataHelper.getPoints();
    String body = food.runtimeType == Product
        ? 'product'
        : food.runtimeType == Meal
            ? 'meal'
            : 'food';

    final response = await _functions.httpsCallable('deleteFood').call({
      'title': 'تم حذف ${food.name}',
      'body': body,
      'foodId': food.id,
      'senderData': {
        'email': email!,
        'points': points,
      },
    });
    if (!response.data['success']) throw Error();
  }

  Map<String, String> _setUnitsAsString(List<Unit> units) {
    String unitIds = '';
    String unitNames = '';
    String unitWeights = '';

    for (var unit in units) {
      unitIds += unit.id.toString();
      unitNames += unit.name;
      unitWeights += unit.weight.toString();
    }
    return {
      'unitIds': unitIds,
      'unitNames': unitNames,
      'unitWeights': unitWeights,
    };
  }

  Map<String, String> _setIngrediantsAsString(List<Ingrediant> ingrediants) {
    String ingrediantsIds = '';
    String ingrediantsWeights = '';

    for (var ingrediant in ingrediants) {
      ingrediantsIds += ingrediant.foodId.toString();
      ingrediantsWeights += ingrediant.weight.toString();
    }
    return {
      'ingrediantIds': ingrediantsIds,
      'ingrediantWeights': ingrediantsWeights,
    };
  }

}
