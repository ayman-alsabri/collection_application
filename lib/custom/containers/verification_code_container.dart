import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:collection_application/templates/containers/secondary_curved_container.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerificationCodeContainer extends StatelessWidget {
  final void Function()? onTap;
  final void Function(String) onChanged;
  const VerificationCodeContainer({
    super.key,
    required this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryCurvedContainer(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Responsive.height(50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'كود التوكيد',
                style: TextStyle(
                    fontFamily: 'SF MADA', fontSize: Responsive.width(20)),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            VerificationCodeInput(
              onChanged: onChanged,
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: PrimaryBlueButton(
                onPressed: onTap,
                height: 50,
                width: 202,
                child: Text(
                  'متابعة',
                  style: TextStyle(
                    fontFamily: 'TITR',
                    fontSize: Responsive.width(28),
                    color: strokeGradientStartColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VerificationCodeDigit extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) handleDigitInput;

  const VerificationCodeDigit({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.handleDigitInput,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width(52.5),
      height: Responsive.width(52.5),
      decoration: BoxDecoration(
        color: shadowColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: TextField(
        keyboardType: TextInputType.number,
        maxLength: 1,
        controller: controller,
        decoration: InputDecoration(
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: bluegradientStartColor),
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
            borderSide: BorderSide.none, // No border line
          ),
        ),
        focusNode: focusNode,
        onChanged: handleDigitInput,
        onTapOutside: (event) => Get.focusScope?.unfocus(),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlign: TextAlign.center,
        textAlignVertical: const TextAlignVertical(y: -1),
        style: const TextStyle(
          fontFamily: 'TITR',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class VerificationCodeInput extends StatefulWidget {
  final void Function(String) onChanged;
  const VerificationCodeInput({
    super.key,
    required this.onChanged,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final List<List<dynamic>> _stringFocusNode = List.generate(
    6,
    (index) => [TextEditingController(), FocusNode()],
  );
  String _code = '';

  void _handleDigitInput(String digit) {
    _code = '';
    for (var digit in _stringFocusNode) {
      _code += (digit[0] as TextEditingController).text;
    }
    widget.onChanged(_code);

    if (digit.isEmpty && !_stringFocusNode.first[1].hasFocus) {
      Get.focusScope?.previousFocus();
      return;
    }
    Get.focusScope?.nextFocus();
  }

  @override
  void initState() {
    super.initState();

    // Add listeners to each focus node
    for (int i = 0; i < _stringFocusNode.length; i++) {
      _stringFocusNode[i][1].addListener(() {
        if (_stringFocusNode[i][1].hasFocus &&
            (_stringFocusNode[i][0] as TextEditingController).text.isEmpty) {
          FocusScope.of(context)
              .requestFocus(_stringFocusNode[_stringFocusNode.indexWhere(
            (element) => element[0].text.isEmpty,
          )][1]);
        }
      });
    }
  }

  @override
  void dispose() {
    // Clean up controllers and focus nodes

    for (var controller in _stringFocusNode) {
      controller[0].dispose();
    }

    for (var focusNode in _stringFocusNode) {
      focusNode[1].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _stringFocusNode
            .map(
              (e) => VerificationCodeDigit(
                controller: e[0],
                focusNode: e[1],
                handleDigitInput: _handleDigitInput,
              ),
            )
            .toList(),
      ),
    );
  }
}
