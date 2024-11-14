import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:collection_application/custom/button/grey_color_square_button.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class AddSubtractButtons extends StatefulWidget {
  final void Function(int number) onChanged;
  const AddSubtractButtons({super.key, required this.onChanged});

  @override
  State<AddSubtractButtons> createState() => _AddSubtractButtonsState();
}

class _AddSubtractButtonsState extends State<AddSubtractButtons> {
  int _currentNmuber = 1;
  @override
  Widget build(BuildContext context) {
    final containersHight = Responsive.height(30);
    const padding = 3.0;
    return Container(
      padding: const EdgeInsets.all(padding),
      constraints: BoxConstraints(
        maxWidth: Responsive.width(89),
        minWidth: Responsive.width(69),
      ),
      height: containersHight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.white12,
            offset: Offset(1, 1),
            blurRadius: 0.4,
          ),
          BoxShadow(color: cravedButtonTopShadow),
          BoxShadow(
              color: cravedButtonColor,
              offset: Offset(2, 2),
              spreadRadius: -2,
              blurRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: GreyColorSquareButton(
                shadows: null,
                animationDuration: const Duration(milliseconds: 80),
                onPressed: () {
                  if (_currentNmuber == 1) return;
                  setState(() {
                    _currentNmuber -= 1;
                  });
                  widget.onChanged(_currentNmuber);
                },
                borderRadius: 5,
                iconName: 'subtract.png',
                buttonSize: containersHight - padding,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('$_currentNmuber'),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: BlueSqareButton(
                animationDuration: const Duration(milliseconds: 80),
                onPressed: () {
                  setState(() {
                    _currentNmuber += 1;
                  });
                  widget.onChanged(_currentNmuber);
                },
                borderRadius: 5,
                iconName: 'add.png',
                buttonSize: containersHight - padding,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
