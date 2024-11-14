import 'package:collection_application/app/views/home/bottomSheet/components/food/widgets/food_unit.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FoodUnitsAdderController extends GetxController {
  final List<Map<String, String>> _rawUnits = [];
  late final RxList<FoodUnit> units = <FoodUnit>[].obs;

  List<Map<String, String>> get getUnits {
    if (!_validate(_rawUnits)) throw Error();
    return _rawUnits;
  }

  void addUnit() {
    if (!_validate(_rawUnits)) {
      return;
    }
    _rawUnits.add({'name': 'الاسم', 'calories': ''});
    units.add(
      FoodUnit(
        key: UniqueKey(),
        initalValue: _rawUnits.last['name']!,
        onDismissed: (key) {
          final itemIndex = units.indexWhere(
            (element) => element.key == key,
          );
          _rawUnits.removeAt(itemIndex);
          units.removeAt(itemIndex);
        },
        onChanged: (name, calories, key) {
          final itemIndex = units.indexWhere(
            (element) => element.key == key,
          );

          _rawUnits[itemIndex]['name'] = name ?? _rawUnits[itemIndex]['name']!;
          _rawUnits[itemIndex]['calories'] =
              calories ?? _rawUnits[itemIndex]['calories']!;
        },
      ),
    );
  }

  bool _validate(List<Map<String, String>> rawUnits) {
    for (var rawUnit in rawUnits) {
      if (rawUnit['name'] == 'الاسم' || rawUnit['name']!.isEmpty) {
        showCustomSnackBar('خطأ', 'يوجد وحدة بدون اسم');
        return false;
      }
      if (double.tryParse(rawUnit['calories']!) == 0 ||
          rawUnit['calories']!.isEmpty) {
        showCustomSnackBar('خطأ', 'يوجد وحدة بدون قيمة سعرات');
        return false;
      }
    }
    return true;
  }
}
