import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/meals/widgets/ingrediant_field.dart';
import 'package:collection_application/custom/dialog/foodFinderDialog/food_finder_dialog.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class IngrediantAdderController extends GetxController {
  double _remainingWeight = 100.0;
  final List<Ingrediant> _ingrediants = [];
  late final RxList<IngrediantField> ingrediantFields = <IngrediantField>[].obs;

  List<Ingrediant> get getIngrediants {
    if (!_areValid(_ingrediants)) {
      throw Error();
    }

    return _ingrediants;
  }

  void addIngrediant() async {
    _updateRemainingWeight();
    if (!_canAdd(_ingrediants)) {
      showCustomSnackBar(
          'لا يمكن الاضافة', "مجموع الأوزان لا يمكن أن يتجاوز 100 غرام");
      return;
    }

    final foodIngrediantList = await FoodFinderDialog.show();
    if (foodIngrediantList == null || foodIngrediantList.isEmpty) return;

    final Food pickedFood = foodIngrediantList[0];
    final Ingrediant pickedIngrediant = foodIngrediantList[1];
    if (pickedIngrediant.existsBetween(_ingrediants)) {
      showCustomSnackBar(
          'لا يمكن اختيار هذا الطعام', '${pickedFood.name} موجود بالفعل',
          duration: const Duration(milliseconds: 5000));
      return;
    }
    if (pickedIngrediant.weight > _remainingWeight) {
      showCustomSnackBar('الوزن المسموح $_remainingWeight غرام',
          'وزن القيم المختارة ${pickedIngrediant.weight} غرام أكثر من الوزن المسموح',
          duration: const Duration(milliseconds: 5000));
      return;
    }

    _remainingWeight -= pickedIngrediant.weight;
    _ingrediants.add(pickedIngrediant);
    ingrediantFields.add(
      IngrediantField(
        key: UniqueKey(),
        weightValue: pickedIngrediant.weight,
        onValueChanges: (weight, key) {
          final index =
              ingrediantFields.indexWhere((element) => element.key == key);

          _ingrediants[index].weight =
              double.tryParse(weight) ?? _ingrediants[index].weight;
        },
        name: pickedFood.name,
        onDismissed: (key) {
          final index =
              ingrediantFields.indexWhere((element) => element.key == key);

          _ingrediants.removeAt(index);
          ingrediantFields.removeAt(index);
        },
      ),
    );
  }

  bool _canAdd(List<Ingrediant> ingrediants) {
    return _remainingWeight > 0;
  }

  bool _areValid(List<Ingrediant> ingrediants) {
    _updateRemainingWeight();
    if (_remainingWeight < 0) {
      showCustomSnackBar(
          'لا يمكن الحفظ', "مجموع الأوزان لا يمكن أن يتجاوز 100 غرام");
      return false;
    }
    if (_remainingWeight <= 100 && _remainingWeight > 0) {
      showCustomSnackBar(
          'لا يمكن الحفظ', "متبقي $_remainingWeight غرام من أوزان المكونات ");
     return false;
    }
    return true;
  }

  void _updateRemainingWeight() {
    _remainingWeight = 100 - _getTotalWeight(_ingrediants);
  }

  double _getTotalWeight(List<Ingrediant> ingrediants) {
    double totalWeight = 0;
    for (var ingrediant in ingrediants) {
      totalWeight += ingrediant.weight;
    }
    return totalWeight;
  }
}
