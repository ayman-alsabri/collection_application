import 'package:collection_application/app/views/home/bottomSheet/widgets/input_text_field.dart';
import 'package:collection_application/app/views/home/bottomSheet/widgets/name_text_field.dart';
import 'package:flutter/material.dart';

class FoodUnit extends StatelessWidget {
  final String initalValue;
  final void Function(String? name, String? calories, Key key) onChanged;
  final void Function(Key key) onDismissed;

  const FoodUnit({
    required super.key,
    required this.initalValue,
    required this.onDismissed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: key!,
      onDismissed: (direction) => onDismissed(key!),
      child: Column(
        children: [
          NameTextField(
            onChanged: (p0) => onChanged(p0, null, key!),
            initalValue: initalValue,
          ),
          const SizedBox(height: 8),
          InputTextField(
            // canRequestFocus: canRequestFocus,
            onChanged: (p0) => onChanged(null, p0, key!),
            //  (p0) => trueonValueChanges(barCode: p0),
            hintText: 'السعرات',
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
