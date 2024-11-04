import 'package:collection_application/templates/containers/general_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MealsBottomSheet extends StatelessWidget {
  const MealsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralBottomSheet(
      firstButtonName: 'القيمة الغذائية',
      secondButtonName: 'المكونات',
      child: Placeholder(),
    );
  }
}
