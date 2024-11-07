import 'package:collection_application/app/views/home/bottomSheet/components/nutritional_value_field.dart';
import 'package:collection_application/templates/containers/general_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MealsBottomSheet extends StatelessWidget {
  const MealsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralBottomSheet(
      firstButtonName: 'القيمة الغذائية',
      secondButtonName: 'المكونات',
      firstField: NutritionalValueField(
          onValueChanges: ({calories, carb, fat, name, protine,notes}) => null),
      secondField: Placeholder(),
    );
  }
}
