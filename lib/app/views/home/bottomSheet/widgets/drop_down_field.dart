import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class Dropdownfield extends StatefulWidget {
  final void Function(String?) onChanged;

  const Dropdownfield({super.key, required this.onChanged});

  @override
  State<Dropdownfield> createState() => _DropdownfieldState();
}

class _DropdownfieldState extends State<Dropdownfield> {
  String _focusedValue = 'لا شيء';
  final _textStyle = TextStyle(
      fontFamily: 'TITR',
      fontSize: Responsive.width(25),
      color: Colors.white.withOpacity(0.8));

  final _categorys = [
    'لا شيء',
    'غني بالبروتين',
    'غني بالكارب',
    'غني بالدهون',
    'منخفض السعرات',
    'غني بالألياف',
    'منخفض الدهون',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height(62),
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: shadowColor.withOpacity(0.3),
      ),
      child: DropdownButton(
          underline: const SizedBox.shrink(),
          isExpanded: true,
          value: _focusedValue,
          items: List.generate(
            _categorys.length,
            (index) => DropdownMenuItem(
                value: _categorys[index],
                child: Text(_categorys[index], style: _textStyle)),
          ),
          onChanged: (value) {
            setState(() {
              _focusedValue = value ?? '';
            });
      
            widget.onChanged(value);
          }),
    );
  }
}
