import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/food/widgets/food_units_adder.dart';
import 'package:collection_application/app/views/home/bottomSheet/widgets/input_text_field.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:flutter/material.dart';

class ProductsBarcodeForm extends StatelessWidget {
  final bool canRequestFocus;
  final String productName;
  final void Function() submit;
  final void Function({
    String? barCode,
    String? weight,
  }) onValueChanges;
  const ProductsBarcodeForm({
    super.key,
    required this.canRequestFocus,
    required this.productName,
    required this.submit,
    required this.onValueChanges,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                productName,
                style: TextStyle(
                  fontFamily: 'SF MADA',
                  fontSize: Responsive.width(26),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'البا ركود',
              style: TextStyle(
                fontFamily: 'SF MADA',
                fontSize: Responsive.width(21),
              ),
            ),
            const SizedBox(height: 8),
            InputTextField(
              canRequestFocus: canRequestFocus,
              onChanged: (p0) => onValueChanges(barCode: p0),
              hintText: '',
            ),
            Text(
              'الوزن الصافي',
              style: TextStyle(
                fontFamily: 'SF MADA',
                fontSize: Responsive.width(21),
              ),
            ),
            const SizedBox(height: 8),
            InputTextField(
              canRequestFocus: canRequestFocus,
              onChanged: (p0) => onValueChanges(weight: p0),
              hintText: 'الوزن بالجرام',
            ),
            const SizedBox(height: 8),
            const FoodUnitsAdder(),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: PrimaryBlueButton(
                height: 50,
                width: 202,
                onPressed: submit,
                text: 'متابعة',
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
