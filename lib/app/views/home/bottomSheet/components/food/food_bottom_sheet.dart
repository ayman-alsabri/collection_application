import 'package:collection_application/templates/containers/general_bottom_sheet.dart';
import 'package:flutter/material.dart';

class FoodBottomSheet extends StatelessWidget {
  const FoodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralBottomSheet(
      firstButtonName: 'القيمة الغذائية',
      secondButtonName: 'وحدات القياس',
      child: Placeholder(),
    );
  }
}