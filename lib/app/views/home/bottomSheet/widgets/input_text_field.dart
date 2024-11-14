import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final bool canRequestFocus;
  final String hintText;
  final String? initalValue;
  final bool numeric;
  const InputTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.initalValue,
    this.canRequestFocus = true,
    this.numeric = true,
  });

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
      child: Row(
        children: [
          Text(
            hintText.isEmpty ? '' : "$hintText:",
            style: TextStyle(
                fontFamily: 'TITR',
                fontSize: Responsive.width(25),
                color: Colors.white.withOpacity(0.6)),
          ),
          Expanded(
            child: TextField(
              keyboardType: numeric ? TextInputType.number : TextInputType.name,
              controller: TextEditingController(text: initalValue),
              canRequestFocus: canRequestFocus,
              textInputAction: TextInputAction.next,
              onChanged: onChanged,
              onTapOutside: (p) => Get.focusScope?.unfocus(),
              inputFormatters: numeric
                  ? ([
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ])
                  : null,
              style: TextStyle(
                  fontFamily: 'TITR',
                  fontSize: Responsive.width(25),
                  color: Colors.white.withOpacity(0.8)),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
