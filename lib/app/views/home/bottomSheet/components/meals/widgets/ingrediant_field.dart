import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/bottomSheet/widgets/input_text_field.dart';
import 'package:flutter/material.dart';

class IngrediantField extends StatelessWidget {
  final String name;
  final double weightValue;
  final void Function(String weight, Key key) onValueChanges;
  final void Function(Key key) onDismissed;

  const IngrediantField({
    required super.key,
    required this.name,
    required this.weightValue,
    required this.onDismissed,
    required this.onValueChanges,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        key: key!,
        onDismissed: (direction) => onDismissed(key!),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontFamily: 'SF MADA',
                fontSize: Responsive.width(21),
              ),
            ),
            const SizedBox(height: 8),
            InputTextField(
              initalValue: weightValue.toString(),
              onChanged: (p0) => onValueChanges(p0, key!),
              hintText: 'الوزن',
            ),
          ],
        ));
  }
}
