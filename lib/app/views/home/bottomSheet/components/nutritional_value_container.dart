import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/bottomSheet/input_text_field.dart';
import 'package:flutter/material.dart';

class NutritionalValueContainer extends StatelessWidget {
  final void Function(String name)? onNameChanged;
  const NutritionalValueContainer({super.key, required this.onNameChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
              onChanged: onNameChanged,
              hintText: '',
              numeric: false,
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
              onChanged: onNameChanged,
              hintText: 'السعرات',
            ),
            const SizedBox(height: 8),
            InputTextField(
              onChanged: onNameChanged,
              hintText: 'البروتين',
            ),
            const SizedBox(height: 8),
            InputTextField(
              onChanged: onNameChanged,
              hintText: 'الكارب',
            ),
            const SizedBox(height: 8),
            InputTextField(
              onChanged: onNameChanged,
              hintText: 'الدهون',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
