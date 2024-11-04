import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class CaloriesButtomContainer extends StatelessWidget {
  const CaloriesButtomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: shadowColor),
        BoxShadow(
            color: bottomGradientStartColor,
            offset: Offset(0, 6),
            blurRadius: 4,
            spreadRadius: 2),
      ]),
      child: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) => const SizedBox(
          height: 40,
        ),
      ),
    );
  }
}
