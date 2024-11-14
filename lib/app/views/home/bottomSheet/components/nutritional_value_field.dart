import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/bottomSheet/widgets/drop_down_field.dart';
import 'package:collection_application/app/views/home/bottomSheet/widgets/input_text_field.dart';
import 'package:flutter/material.dart';

class NutritionalValueField extends StatelessWidget {
  final void Function({
    String? name,
    String? calories,
    String? protine,
    String? carb,
    String? fat,
    String? notes,
  }) onValueChanges;
  const NutritionalValueField({super.key, required this.onValueChanges});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: SingleChildScrollView(
        child: FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الاسم",
                style: TextStyle(
                  fontFamily: 'SF MADA',
                  fontSize: Responsive.width(21),
                ),
              ),
              const SizedBox(height: 8),
              InputTextField(
                onChanged: (p0) => onValueChanges(name: p0),
                hintText: '',
                numeric: false,
              ),
              const SizedBox(height: 16),
              Text(
                "الفئة",
                style: TextStyle(
                  fontFamily: 'SF MADA',
                  fontSize: Responsive.width(21),
                ),
              ),
              const SizedBox(height: 8),
              Dropdownfield(
                onChanged: (p0) => onValueChanges(notes: p0),
              ),
              const SizedBox(height: 16),
              Text(
                "القيمة الغذائية لكل 100غرام",
                style: TextStyle(
                  fontFamily: 'SF MADA',
                  fontSize: Responsive.width(21),
                ),
              ),
              const SizedBox(height: 8),
              InputTextField(
                onChanged: (p0) => onValueChanges(calories: p0),
                hintText: 'السعرات',
              ),
              const SizedBox(height: 8),
              InputTextField(
                onChanged: (p0) => onValueChanges(protine: p0),
                hintText: 'البروتين',
              ),
              const SizedBox(height: 8),
              InputTextField(
                onChanged: (p0) => onValueChanges(carb: p0),
                hintText: 'الكارب',
              ),
              const SizedBox(height: 8),
              InputTextField(
                onChanged: (p0) => onValueChanges(fat: p0),
                hintText: 'الدهون',
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
