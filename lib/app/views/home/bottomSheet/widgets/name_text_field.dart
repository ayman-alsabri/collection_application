import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/custom/button/completeButtons/text_icon_press_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameTextField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String initalValue;
  const NameTextField({
    super.key,
    required this.initalValue,
    required this.onChanged,
  });

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initalValue);
  final _focusNode = FocusNode();

  late double _textFieldWidth;
  final _textStyle =
      TextStyle(fontFamily: 'SF MADA', fontSize: Responsive.width(21));
  bool _readOnly = true;

  @override
  void initState() {
    super.initState();
    _textFieldWidth = _calculateTextWidth(_controller.text) + 16;
    _controller.addListener(_updateTextFieldWidth);
  }

  void _updateTextFieldWidth() {
    setState(() {
      _textFieldWidth = _calculateTextWidth(_controller.text) + 16;
    });
  }

  double _calculateTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: _textStyle),
      maxLines: 1,
      textDirection: TextDirection.rtl,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  void _enableEditing() {
    setState(() {
      _readOnly = false;
    });
    _focusNode.requestFocus();
  }

  void _disableEditing(PointerDownEvent p0) {
    setState(() {
      _readOnly = true;
    });
    Get.focusScope?.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_updateTextFieldWidth)
      ..dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: _textFieldWidth,
          child: TextField(
            maxLength: 20,
            maxLines: 1,
            onTapOutside: _disableEditing,
            readOnly: _readOnly,
            onChanged: widget.onChanged,
            controller: _controller,
            focusNode: _focusNode,
            style: _textStyle,
            decoration: const InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none, gapPadding: 0)),
          ),
        ),
        TextIconPressButton(
          width: 80,
          iconName: 'edit.png',
          text: 'تعديل',
          onPressed: _enableEditing,
        )
      ],
    );
  }
}
