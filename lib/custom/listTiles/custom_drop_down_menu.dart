import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final List<Unit> units;
  final void Function(Unit? tappedUnit) onTap;

  const CustomDropDownMenu({
    required super.key,
    required this.units,
    required this.onTap,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  late Unit _currentlySelectedUnit = widget.units.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Responsive.width(80),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: DropdownButton(
          underline: const SizedBox.shrink(),
          value: _currentlySelectedUnit,
          items: widget.units
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                    style: TextStyle(
                      fontFamily: 'SF MADA',
                      fontSize: Responsive.width(13),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              _currentlySelectedUnit = value ?? widget.units.first;
            });
            widget.onTap(value);
          },
        ),
      ),
    );
  }
}
