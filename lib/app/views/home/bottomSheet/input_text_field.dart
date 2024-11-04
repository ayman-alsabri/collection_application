import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String hintText;
  final bool numeric;
  const InputTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.numeric = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height(62),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: shadowColor.withOpacity(0.3),
      ),
      child: TextField(
        key: ValueKey(hintText),
        onChanged: onChanged,
        onTapOutside: (p) => Get.focusScope?.unfocus(),
        keyboardType: numeric ? TextInputType.number : TextInputType.name,
        inputFormatters:
            numeric ? ([FilteringTextInputFormatter.digitsOnly]) : null,
        style: TextStyle(
            fontFamily: 'TITR',
            fontSize: Responsive.width(25),
            color: Colors.white.withOpacity(0.8)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: 'TITR',
              fontSize: Responsive.width(25),
              color: Colors.white.withOpacity(0.6)),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
